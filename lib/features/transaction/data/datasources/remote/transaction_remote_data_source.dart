import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/features/transaction/data/models/transaction_model.dart';
import 'package:better_pro_assignment/core/constants/api_constants.dart';

abstract class TransactionRemoteDataSource {
  Future<TransactionModel> submitTransaction(TransactionModel transaction);
  Future<TransactionModel> checkTransactionStatus(String id);
}

@LazySingleton(as: TransactionRemoteDataSource)
class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio _dio;

  TransactionRemoteDataSourceImpl(this._dio);

  @override
  Future<TransactionModel> submitTransaction(TransactionModel transaction) async {
    // Using /mock path to trigger MockServerInterceptor
    final response = await _dio.post(
      ApiConstants.submitTransaction,
      data: transaction.toJson(),
    );
    // In real app, response structure might differ.
    // Here we assume server returns the full transaction object.
    
    // Safely cast response data to Map<String, dynamic>
    final data = Map<String, dynamic>.from(response.data as Map);
    return TransactionModel.fromJson(data);
  }

  @override
  Future<TransactionModel> checkTransactionStatus(String id) async {
    final response = await _dio.get(
      ApiConstants.checkStatus,
      queryParameters: {'id': id},
    );
    // In real app, response structure might differ.
    // Here we assume server returns the full transaction object.

    // Safely cast response data to Map<String, dynamic>
    final data = Map<String, dynamic>.from(response.data as Map);
    return TransactionModel.fromJson(data);
  }
}
