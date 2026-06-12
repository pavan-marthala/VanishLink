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
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';
import 'package:vanish_link/features/chat/data/repositories/presence_repository_impl.dart';
import 'package:vanish_link/features/chat/domain/services/presence_service.dart';
import 'package:vanish_link/features/chat/presentation/bloc/presence/presence_bloc.dart';
import 'package:vanish_link/features/chat/domain/repositories/webrtc_repository.dart';
import 'package:vanish_link/features/chat/data/repositories/webrtc_repository_impl.dart';
import 'package:vanish_link/features/chat/domain/repositories/signaling_repository.dart';
import 'package:vanish_link/features/chat/data/repositories/signaling_repository_impl.dart';
import 'package:vanish_link/features/chat/domain/services/webrtc_service.dart';
import 'package:vanish_link/features/chat/presentation/bloc/webrtc/webrtc_bloc.dart';
import 'package:vanish_link/features/chat/domain/repositories/message_repository.dart';
import 'package:vanish_link/features/chat/data/repositories/message_repository_impl.dart';
import 'package:vanish_link/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:vanish_link/features/chat/domain/services/unread_service.dart';
import 'package:vanish_link/features/chat/domain/repositories/call_repository.dart';
import 'package:vanish_link/features/chat/data/repositories/call_repository_impl.dart';
import 'package:vanish_link/features/chat/domain/services/call_listener_service.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_bloc.dart';
import 'package:vanish_link/features/chat/domain/services/ringtone_service.dart';
import 'package:vanish_link/features/chat/domain/services/call_notification_service.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:vanish_link/features/chat/domain/services/call_presentation_adapter.dart';
import 'package:vanish_link/features/chat/domain/services/call_coordinator.dart';


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

  getIt.registerLazySingleton<PresenceRepository>(
    () => PresenceRepositoryImpl(),
  );

  getIt.registerLazySingleton<PresenceService>(
    () => PresenceService(presenceRepository: getIt<PresenceRepository>()),
  );

  getIt.registerLazySingleton<WebRtcRepository>(
    () => WebRtcRepositoryImpl(),
  );

  getIt.registerLazySingleton<SignalingRepository>(
    () => SignalingRepositoryImpl(),
  );

  getIt.registerLazySingleton<WebRtcService>(
    () => WebRtcService(
      webRtcRepository: getIt<WebRtcRepository>(),
      signalingRepository: getIt<SignalingRepository>(),
    ),
  );

  getIt.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(),
  );

  getIt.registerLazySingleton<UnreadService>(
    () => UnreadService(
      messageRepository: getIt<MessageRepository>(),
      auth: getIt<FirebaseAuth>(),
    ),
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

  getIt.registerFactory<PresenceBloc>(
    () => PresenceBloc(presenceRepository: getIt<PresenceRepository>()),
  );

  getIt.registerFactory<WebRtcBloc>(
    () => WebRtcBloc(webRtcService: getIt<WebRtcService>()),
  );

  getIt.registerFactory<MessageBloc>(
    () => MessageBloc(messageRepository: getIt<MessageRepository>()),
  );

  // Call Feature
  getIt.registerLazySingleton<CallRepository>(
    () => CallRepositoryImpl(),
  );

  getIt.registerLazySingleton<CallListenerService>(
    () => CallListenerService(
      callRepository: getIt<CallRepository>(),
      auth: getIt<FirebaseAuth>(),
    ),
  );

  getIt.registerLazySingleton<CallBloc>(
    () => CallBloc(callRepository: getIt<CallRepository>()),
  );

  getIt.registerLazySingleton<RingtoneService>(() => RingtoneService());
  getIt.registerLazySingleton<CallNotificationService>(() => CallNotificationService());
  getIt.registerLazySingleton<CallPresentationAdapter>(() {
    if (kIsWeb) {
      return WebCallAdapter();
    } else if (Platform.isAndroid) {
      return AndroidCallAdapter();
    } else if (Platform.isIOS) {
      return IOSCallAdapter();
    } else {
      return DesktopCallAdapter();
    }
  });
  getIt.registerLazySingleton<CallCoordinator>(
    () => CallCoordinator(
      callRepository: getIt<CallRepository>(),
      presenceRepository: getIt<PresenceRepository>(),
      ringtoneService: getIt<RingtoneService>(),
      notificationService: getIt<CallNotificationService>(),
      callKitAdapter: getIt<CallPresentationAdapter>(),
    ),
  );
}
