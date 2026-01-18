import 'package:better_pro_assignment/features/transaction/domain/entities/transaction_status.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/features/transaction/data/models/transaction_model.dart';
import 'package:better_pro_assignment/core/constants/di_keys.dart';

abstract class TransactionLocalDataSource {
  Future<void> saveTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getPendingTransactions();
  Future<void> updateTransactionStatus(String id, String status);
  Future<TransactionModel?> getTransaction(String id);
  Future<List<TransactionModel>> getAllTransactions();
}

@LazySingleton(as: TransactionLocalDataSource)
class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final Box<TransactionModel> _box;

  TransactionLocalDataSourceImpl(
      @Named(DIKeys.transactionBox) this._box);

  @override
  Future<void> saveTransaction(TransactionModel transaction) async {
    await _box.put(transaction.id, transaction);
  }

  @override
  Future<List<TransactionModel>> getPendingTransactions() async {
    return _box.values.where((tx) => 
      tx.status == TransactionStatus.broadcasting.name || 
      tx.status == TransactionStatus.unknown.name
    ).toList();
  }

  @override
  Future<void> updateTransactionStatus(String id, String status) async {
    final tx = _box.get(id);
    if (tx != null) {
      final updatedTx = tx.copyWith(status: status);
      await _box.put(id, updatedTx);
    }
  }

  @override
  Future<TransactionModel?> getTransaction(String id) async {
    return _box.get(id);
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    return _box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
}
