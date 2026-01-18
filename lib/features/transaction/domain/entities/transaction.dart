import 'package:equatable/equatable.dart';
import 'amount.dart';
import 'transaction_status.dart';

class Transaction extends Equatable {
  final String id;
  final Amount amount;
  final TransactionStatus status;
  final int timestamp;

  const Transaction({
    required this.id,
    required this.amount,
    required this.status,
    required this.timestamp,
  });

  Transaction copyWith({
    String? id,
    Amount? amount,
    TransactionStatus? status,
    int? timestamp,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [id, amount, status, timestamp];
}
