import 'package:better_pro_assignment/core/error/failures.dart';
import 'package:better_pro_assignment/core/usecases/usecase.dart';
import 'package:better_pro_assignment/features/transaction/domain/domain.dart';
import 'package:better_pro_assignment/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSubmitTransactionUseCase extends Mock implements SubmitTransactionUseCase {}
class MockRecoverPendingTransactionsUseCase extends Mock implements RecoverPendingTransactionsUseCase {}

void main() {
  late TransactionBloc bloc;
  late MockSubmitTransactionUseCase mockSubmitUseCase;
  late MockRecoverPendingTransactionsUseCase mockRecoverUseCase;

  setUp(() {
    mockSubmitUseCase = MockSubmitTransactionUseCase();
    mockRecoverUseCase = MockRecoverPendingTransactionsUseCase();
    bloc = TransactionBloc(mockSubmitUseCase, mockRecoverUseCase);
    
    // Register fallback value for Amount because it's a custom object
    registerFallbackValue(Amount(value: BigInt.zero, precision: 2, currency: Currency.USD));
    registerFallbackValue(NoParams());
  });

  tearDown(() {
    bloc.close();
  });

  group('TransactionBloc', () {
    const tAmountStr = '10.50';
    const tCurrency = Currency.USD;
    final tTransaction = Transaction(
      id: '123',
      amount: Amount.fromString(tAmountStr, currency: tCurrency),
      status: TransactionStatus.completed,
      timestamp: 123456789,
    );

    test('initial state should be TransactionState.initial', () {
      expect(bloc.state, const TransactionState.initial());
    });

    blocTest<TransactionBloc, TransactionState>(
      'emits [loading, success] when submit is successful',
      build: () {
        when(() => mockSubmitUseCase(any())).thenAnswer((_) async => Right(tTransaction));
        return bloc;
      },
      act: (bloc) => bloc.add(const TransactionEvent.submit(tAmountStr, tCurrency)),
      expect: () => [
        const TransactionState.loading(),
        TransactionState.success(tTransaction),
      ],
      verify: (_) {
        verify(() => mockSubmitUseCase(any())).called(1);
      },
    );

    blocTest<TransactionBloc, TransactionState>(
      'emits [loading, failure] when submit fails',
      build: () {
        when(() => mockSubmitUseCase(any())).thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const TransactionEvent.submit(tAmountStr, tCurrency)),
      expect: () => [
        const TransactionState.loading(),
        const TransactionState.failure('Server Error'),
      ],
    );

    blocTest<TransactionBloc, TransactionState>(
      'emits [loading, failure] when amount is invalid',
      build: () => bloc,
      act: (bloc) => bloc.add(const TransactionEvent.submit('abc', Currency.USD)),
      expect: () => [
        const TransactionState.loading(),
        const TransactionState.failure('Invalid amount format'),
      ],
    );
  });
}
