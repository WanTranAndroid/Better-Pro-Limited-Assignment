import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/features/transaction/domain/domain.dart';
import 'package:better_pro_assignment/core/core.dart';

@lazySingleton
class RecoverPendingTransactionsUseCase implements UseCase<List<Transaction>, NoParams> {
  final TransactionRepository repository;

  RecoverPendingTransactionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) async {
    final pendingOrFailure = await repository.getPendingTransactions();

    return pendingOrFailure.fold(
      (failure) => Left(failure),
      (transactions) async {
        final recoveredList = <Transaction>[];

        // Check status with Server for each
        // Can use Future.wait if large
        for (var tx in transactions) {
          final result = await repository.checkTransactionStatus(tx.id);
          result.fold(
            (failure) {
              // If check fails (e.g. network error), we keep the local state
              // effectively doing nothing, waiting for next retry.
              recoveredList.add(tx);
            },
            (updatedTx) {
              // Status updated (to Success or Failed)
              recoveredList.add(updatedTx);
            },
          );
        }

        return Right(recoveredList);
      },
    );
  }
}
