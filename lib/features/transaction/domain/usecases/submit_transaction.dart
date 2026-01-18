import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/core/core.dart';
import 'package:better_pro_assignment/features/transaction/domain/domain.dart';

@lazySingleton
class SubmitTransactionUseCase implements UseCase<Transaction, Amount> {
  final TransactionRepository repository;

  SubmitTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(Amount amount) async {
    final createdOrFailure = await repository.createTransaction(amount);

    return createdOrFailure.fold(
      (failure) => Left(failure),
      (transaction) async {
        // If this crashes, the 'broadcasting' state is already saved in Step 1.
        return await repository.submitTransaction(transaction);
      },
    );
  }
}
