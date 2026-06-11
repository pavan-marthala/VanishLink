import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:vanish_link/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:vanish_link/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vanish_link/features/auth/domain/repositories/auth_repository.dart';
import 'package:vanish_link/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vanish_link/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:vanish_link/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => FirebaseAuthDataSourceImpl(getIt<FirebaseAuth>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  // Blocs
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerFactory<SignUpBloc>(
    () => SignUpBloc(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerFactory<SignInBloc>(
    () => SignInBloc(authRepository: getIt<AuthRepository>()),
  );
}
