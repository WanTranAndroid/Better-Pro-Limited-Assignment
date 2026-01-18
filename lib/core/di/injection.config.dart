// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/transaction/data/data.dart' as _i861;
import '../../features/transaction/data/datasources/local/transaction_local_data_source.dart'
    as _i693;
import '../../features/transaction/data/datasources/remote/transaction_remote_data_source.dart'
    as _i967;
import '../../features/transaction/data/models/transaction_model.dart' as _i794;
import '../../features/transaction/data/repositories/transaction_repository_impl.dart'
    as _i600;
import '../../features/transaction/domain/domain.dart' as _i1037;
import '../../features/transaction/domain/usecases/recover_pending_transactions.dart'
    as _i973;
import '../../features/transaction/domain/usecases/submit_transaction.dart'
    as _i34;
import '../../features/transaction/presentation/bloc/transaction_bloc.dart'
    as _i356;
import '../../features/transaction/presentation/resolvers/risk_challenge_resolver_impl.dart'
    as _i993;
import '../core.dart' as _i351;
import '../network/interceptors/auth_interceptor.dart' as _i745;
import '../network/interceptors/mock_server_interceptor.dart' as _i457;
import '../network/interceptors/retry_interceptor.dart' as _i914;
import '../network/interceptors/risk_interceptor.dart' as _i815;
import 'local_module.dart' as _i519;
import 'network_module.dart' as _i567;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final localModule = _$LocalModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i745.AuthInterceptor>(() => _i745.AuthInterceptor());
    gh.factory<_i457.MockServerInterceptor>(
        () => _i457.MockServerInterceptor());
    gh.factory<_i914.RetryInterceptor>(() => _i914.RetryInterceptor());
    gh.lazySingleton<_i351.RiskChallengeResolver>(
        () => _i993.RiskChallengeResolverImpl());
    await gh.factoryAsync<_i979.Box<_i861.TransactionModel>>(
      () => localModule.transactionBox,
      instanceName: 'transactionBox',
      preResolve: true,
    );
    gh.factory<_i815.RiskInterceptor>(
        () => _i815.RiskInterceptor(gh<_i351.RiskChallengeResolver>()));
    gh.lazySingleton<_i693.TransactionLocalDataSource>(() =>
        _i693.TransactionLocalDataSourceImpl(
            gh<_i979.Box<_i794.TransactionModel>>(
                instanceName: 'transactionBox')));
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio(
          gh<_i351.RetryInterceptor>(),
          gh<_i351.AuthInterceptor>(),
          gh<_i351.RiskInterceptor>(),
          gh<_i351.MockServerInterceptor>(),
        ));
    gh.lazySingleton<_i967.TransactionRemoteDataSource>(
        () => _i967.TransactionRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i1037.TransactionRepository>(
        () => _i600.TransactionRepositoryImpl(
              gh<_i861.TransactionLocalDataSource>(),
              gh<_i861.TransactionRemoteDataSource>(),
            ));
    gh.lazySingleton<_i973.RecoverPendingTransactionsUseCase>(() =>
        _i973.RecoverPendingTransactionsUseCase(
            gh<_i1037.TransactionRepository>()));
    gh.lazySingleton<_i34.SubmitTransactionUseCase>(() =>
        _i34.SubmitTransactionUseCase(gh<_i1037.TransactionRepository>()));
    gh.factory<_i356.TransactionBloc>(() => _i356.TransactionBloc(
          gh<_i1037.SubmitTransactionUseCase>(),
          gh<_i1037.RecoverPendingTransactionsUseCase>(),
        ));
    return this;
  }
}

class _$LocalModule extends _i519.LocalModule {}

class _$NetworkModule extends _i567.NetworkModule {}
