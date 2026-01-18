import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:better_pro_assignment/core/error/failures.dart';
import 'package:better_pro_assignment/features/transaction/domain/domain.dart';
import 'package:better_pro_assignment/features/transaction/data/data.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;
  final TransactionRemoteDataSource remoteDataSource;
  final Uuid _uuid = const Uuid();

  TransactionRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, Transaction>> createTransaction(Amount amount) async {
    try {
      final id = _uuid.v4();
      final model = TransactionModel(
        id: id,
        amountValue: amount.value.toString(),
        amountPrecision: amount.precision,
        currency: amount.currency.code,
        status: TransactionStatus.created.name,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

      await localDataSource.saveTransaction(model);
      return Right(model.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> submitTransaction(Transaction transaction) async {
    try {
      // 1. Update Local to 'broadcasting'
      await localDataSource.updateTransactionStatus(transaction.id, TransactionStatus.broadcasting.name);

      // 2. Call Remote
      // Convert entity to model for API
      final requestModel = TransactionModel.fromEntity(transaction);
      
      final responseModel = await remoteDataSource.submitTransaction(requestModel);

      // 3. Update Local with final status
      await localDataSource.saveTransaction(responseModel);

      return Right(responseModel.toEntity());
    } on DioException catch (e) {
      // Handle Network Errors
      if (e.response?.statusCode == 403) {
        // Should be handled by Interceptor, but if it leaks:
         await localDataSource.updateTransactionStatus(transaction.id, TransactionStatus.riskChallenge.name);
         return const Left(RiskChallengeFailure('Risk Challenge Required'));
      } 
      
      // Check for 504 or timeouts
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout || 
          e.response?.statusCode == 504) {
         // Timeout -> Unknown State
         await localDataSource.updateTransactionStatus(transaction.id, TransactionStatus.unknown.name);
         return const Left(UnknownFailure('Transaction status unknown due to timeout'));
      }

      // Other errors -> Failed
      await localDataSource.updateTransactionStatus(transaction.id, TransactionStatus.failed.name);
      return Left(ServerFailure(e.message ?? 'Unknown Server Error'));
    } catch (e) {
      // App crash or other error -> Unknown or Failed?
      // Safer to keep as broadcasting/unknown if we are not sure
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> checkTransactionStatus(String id) async {
    try {
      final responseModel = await remoteDataSource.checkTransactionStatus(id);
      
      await localDataSource.saveTransaction(responseModel);
      
      return Right(responseModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getPendingTransactions() async {
    try {
      final models = await localDataSource.getPendingTransactions();
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
