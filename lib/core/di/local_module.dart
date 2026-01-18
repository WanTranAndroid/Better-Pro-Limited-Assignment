import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/features/transaction/data/data.dart';
import 'package:better_pro_assignment/core/constants/hive_type_ids.dart';
import 'package:better_pro_assignment/core/constants/di_keys.dart';

@module
abstract class LocalModule {
  @preResolve
  @Named(DIKeys.transactionBox)
  Future<Box<TransactionModel>> get transactionBox async {
    // Adapter registration
    if (!Hive.isAdapterRegistered(HiveTypeIds.transactionModel)) {
       // Use the exposed getter from transaction_model.dart
       Hive.registerAdapter(transactionModelAdapter);
    }
    return await Hive.openBox<TransactionModel>('transactions');
  }
}
