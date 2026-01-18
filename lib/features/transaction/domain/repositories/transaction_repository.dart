import 'package:dartz/dartz.dart';
import 'package:better_pro_assignment/core/core.dart';
import 'package:better_pro_assignment/features/transaction/domain/domain.dart';


abstract class TransactionRepository {
  Future<Either<Failure, Transaction>> createTransaction(Amount amount);

  Future<Either<Failure, Transaction>> submitTransaction(Transaction transaction);

  Future<Either<Failure, Transaction>> checkTransactionStatus(String id);

  Future<Either<Failure, List<Transaction>>> getPendingTransactions();
}
