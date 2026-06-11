import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:vanish_link/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:vanish_link/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vanish_link/features/auth/domain/repositories/auth_repository.dart';
import 'package:vanish_link/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vanish_link/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:vanish_link/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:vanish_link/features/discover/domain/repositories/discover_repository.dart';
import 'package:vanish_link/features/discover/data/repositories/discover_repository_impl.dart';
import 'package:vanish_link/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:vanish_link/features/request/domain/repositories/request_repository.dart';
import 'package:vanish_link/features/request/data/repositories/request_repository_impl.dart';
import 'package:vanish_link/features/request/presentation/bloc/requests_bloc.dart';
import 'package:vanish_link/features/chat/domain/repositories/chat_repository.dart';
import 'package:vanish_link/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:vanish_link/features/chat/presentation/bloc/chats_bloc.dart';
import 'package:vanish_link/features/profile/domain/repositories/profile_repository.dart';
import 'package:vanish_link/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:vanish_link/features/profile/presentation/bloc/profile_bloc.dart';

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

  getIt.registerLazySingleton<DiscoverRepository>(
    () => DiscoverRepositoryImpl(),
  );

  getIt.registerLazySingleton<RequestRepository>(
    () => RequestRepositoryImpl(),
  );

  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(),
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

  getIt.registerFactory<DiscoverBloc>(
    () => DiscoverBloc(discoverRepository: getIt<DiscoverRepository>()),
  );

  getIt.registerFactory<RequestsBloc>(
    () => RequestsBloc(requestRepository: getIt<RequestRepository>()),
  );

  getIt.registerFactory<ChatsBloc>(
    () => ChatsBloc(chatRepository: getIt<ChatRepository>()),
  );

  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(profileRepository: getIt<ProfileRepository>()),
  );
}
