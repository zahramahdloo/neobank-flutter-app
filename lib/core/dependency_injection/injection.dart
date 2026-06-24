import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/data/datasources/auth_remote_datasourece.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/autho_repository.dart';
import '../../features/auth/domain/usecase/sign_in_usecase.dart';
import '../../features/auth/domain/usecase/sign_up_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/home/data/datasources/bank_remote_datasource.dart';
import '../../features/home/data/repositories/bank_repository_impl.dart';
import '../../features/home/domain/repositories/bank_repository.dart';
import '../../features/home/domain/usecase/get_account_usecase.dart';
import '../../features/home/domain/usecase/get_transactions_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../theme/cubit/theme_cubit.dart';

final sl = GetIt.instance;

void setupDependencies() {
  _registerCore();
  _registerAuthFeature();
  _registerHomeFeature();
}

void _registerCore() {
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}

void _registerHomeFeature() {
  sl.registerLazySingleton<BankRemoteDataSource>(() => BankRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<BankRepository>(() => BankRepositoryImpl(sl()));

  sl.registerLazySingleton<GetAccountsUseCase>(() => GetAccountsUseCase(sl()));

  sl.registerLazySingleton<GetTransactionsUseCase>(() => GetTransactionsUseCase(sl()));

  sl.registerFactory<HomeCubit>(
    () => HomeCubit(getAccountsUseCase: sl(), getTransactionsUseCase: sl()),
  );
}

void _registerAuthFeature() {
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl()));

  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));

  sl.registerFactory<AuthCubit>(() => AuthCubit(signInUseCase: sl(), signUpUseCase: sl()));
  sl.registerLazySingleton(() => ThemeCubit());
}
