import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/core/usecases/usecase.dart';
import 'package:better_pro_assignment/features/transaction/domain/domain.dart';

part 'transaction_bloc.freezed.dart';

@freezed
class TransactionEvent with _$TransactionEvent {
  const factory TransactionEvent.submit(String amount, Currency currency) = _Submit;
  const factory TransactionEvent.checkStatus(String id) = _CheckStatus;
  const factory TransactionEvent.recoverPending() = _RecoverPending;
}

@freezed
class TransactionState with _$TransactionState {
  const factory TransactionState.initial() = _Initial;
  const factory TransactionState.loading() = _Loading;
  const factory TransactionState.success(Transaction transaction) = _Success;
  const factory TransactionState.failure(String message) = _Failure;
}

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final SubmitTransactionUseCase _submitTransaction;
  final RecoverPendingTransactionsUseCase _recoverPending;

  TransactionBloc(this._submitTransaction, this._recoverPending)
      : super(const TransactionState.initial()) {
    on<_Submit>(_onSubmit);
    on<_RecoverPending>(_onRecoverPending);
  }

  Future<void> _onSubmit(_Submit event, Emitter<TransactionState> emit) async {
    emit(const TransactionState.loading());

    try {
      // This is a simplified parser for the assignment scope.
      // In a production-level Fintech app, we should use 'intl' package
      // or a custom Locale-aware parser to handle different decimal separators
      // (e.g., '.' in US/UK vs ',' in Vietnam/Germany) and thousands separators.
      final amount = Amount.fromString(
        event.amount, 
        currency: event.currency,
      );
      
      final result = await _submitTransaction(amount);

      result.fold(
        (failure) => emit(TransactionState.failure(failure.message)),
        (transaction) => emit(TransactionState.success(transaction)),
      );
    } catch (e) {
      emit(const TransactionState.failure('Invalid amount format'));
    }
  }

  Future<void> _onRecoverPending(_RecoverPending event, Emitter<TransactionState> emit) async {
     final result = await _recoverPending(NoParams());
     result.fold(
       (failure) => null, // Notify UI
       (transactions) {
         if (transactions.isNotEmpty) {
           // Notify UI or update list if we had one
         }
       }
     );
  }
}
