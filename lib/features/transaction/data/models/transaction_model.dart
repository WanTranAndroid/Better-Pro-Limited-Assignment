import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:better_pro_assignment/features/transaction/domain/domain.dart';
import 'package:better_pro_assignment/core/constants/hive_type_ids.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  @HiveType(typeId: HiveTypeIds.transactionModel)
  const factory TransactionModel({
    @HiveField(0) required String id,
    @HiveField(1) required String amountValue, // Stored as String for BigInt safety
    @HiveField(2) required int amountPrecision,
    @HiveField(3) required String currency,
    @HiveField(4) required String status, // Stored as String for Enum flexibility
    @HiveField(5) required int timestamp,
  }) = _TransactionModel;

  const TransactionModel._();

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  // Mapper: Model -> Entity
  Transaction toEntity() {
    return Transaction(
      id: id,
      amount: Amount(
        value: BigInt.parse(amountValue),
        precision: amountPrecision,
        currency: Currency.values.firstWhere(
          (e) => e.code == currency,
          orElse: () => Currency.USD,
        ),
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => TransactionStatus.unknown,
      ),
      timestamp: timestamp,
    );
  }

  // Mapper: Entity -> Model
  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      amountValue: transaction.amount.value.toString(),
      amountPrecision: transaction.amount.precision,
      currency: transaction.amount.currency.code,
      status: transaction.status.name,
      timestamp: transaction.timestamp,
    );
  }
}

// Expose the adapter for DI
TypeAdapter get transactionModelAdapter => TransactionModelImplAdapter();
