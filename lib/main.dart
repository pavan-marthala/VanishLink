import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/routes/app_routes.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/sized_context.dart';
import 'package:vanish_link/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vanish_link/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:vanish_link/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:vanish_link/features/auth/presentation/screens/splash_screen.dart';
import 'package:vanish_link/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:vanish_link/features/chat/presentation/screens/chat_screen.dart';
import 'package:vanish_link/features/home/presentation/screens/home_screen.dart';
import 'package:vanish_link/features/profile/presentation/screens/profile_screen.dart';
import 'package:vanish_link/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:vanish_link/features/request/presentation/screens/request_screen.dart';
import 'package:vanish_link/features/discover/presentation/screens/discover_screen.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/domain/services/presence_service.dart';
import 'package:vanish_link/features/chat/domain/services/unread_service.dart';
import 'package:vanish_link/features/chat/domain/services/call_listener_service.dart';
import 'package:vanish_link/features/chat/domain/services/call_coordinator.dart';
import 'package:vanish_link/features/chat/presentation/screens/call_screen.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_bloc.dart';
import 'package:vanish_link/features/chat/presentation/widgets/call_overlay_manager.dart';
import 'package:vanish_link/firebase_options.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GlobalKey<NavigatorState> _shellNavigatorKeyChat =
    GlobalKey<NavigatorState>(debugLabel: 'shell-chat');
final GlobalKey<NavigatorState> _shellNavigatorKeyRequest =
    GlobalKey<NavigatorState>(debugLabel: 'shell-request');
final GlobalKey<NavigatorState> _shellNavigatorKeyProfile =
    GlobalKey<NavigatorState>(debugLabel: 'shell-profile');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Remove debugTransformDebugCreator to prevent LegacyJavaScriptObject casting issues in Flutter Web Inspector
  FlutterErrorDetails.propertiesTransformers.remove(debugTransformDebugCreator);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();

  // Start checking authentication state
  getIt<AuthBloc>().add(const AuthEvent.started());

  // Start presence monitoring
  getIt<PresenceService>().startMonitoring();

  // Start unread counts monitoring
  getIt<UnreadService>().startMonitoring();

  // Start incoming call monitoring
  getIt<CallListenerService>().startMonitoring();

  // Initialize call coordinator
  getIt<CallCoordinator>().initialize();

  runApp(const MyApp());
}

/// Helper class to bridge Stream changes to a ChangeNotifier for GoRouter.
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthBloc _authBloc;
  late final GoRouter _goRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt<AuthBloc>();

    _goRouter = GoRouter(
      initialLocation: AppRoutes.splash,
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      refreshListenable: GoRouterRefreshStream(_authBloc.stream),
      redirect: (context, state) {
        final authState = _authBloc.state;
        final matchedLocation = state.matchedLocation;

        final isSplash = matchedLocation == AppRoutes.splash;
        final isSignIn = matchedLocation == AppRoutes.signIn;
        final isSignUp = matchedLocation == AppRoutes.signUp;

        return authState.map(
          initial: (_) {
            if (!isSplash) {
              return AppRoutes.splash;
            }
            return null;
          },
          authenticated: (_) {
            if (isSplash || isSignIn || isSignUp) {
              return AppRoutes.chats;
            }
            return null;
          },
          unauthenticated: (_) {
            if (!isSignIn && !isSignUp) {
              return AppRoutes.signIn;
            }
            return null;
          },
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoutes.signIn,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: AppRoutes.signUp,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: AppRoutes.discover,
          builder: (context, state) => const DiscoverScreen(),
        ),
        GoRoute(
          path: AppRoutes.call,
          builder: (context, state) {
            final callId = state.pathParameters['callId'] ?? '';
            return CallScreen(callId: callId);
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              HomeScreen(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              navigatorKey: _shellNavigatorKeyChat,
              routes: [
                GoRoute(
                  path: AppRoutes.chats,
                  name: AppRoutes.chats,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: ChatScreen()),
                  routes: [
                    GoRoute(
                      path: ':chatId',
                      pageBuilder: (context, state) {
                        final chatId = state.pathParameters['chatId'];
                        final contact = state.extra as UserProfile?;

                        if (context.isDesktop) {
                          // On tablet/desktop, keep the user on ChatScreen and select this chatId inline
                          return NoTransitionPage(
                            child: ChatScreen(selectedChatId: chatId),
                          );
                        } else {
                          // On mobile, push the details screen full screen
                          return MaterialPage(
                            child: ChatDetailsScreen(
                              chatId: chatId,
                              contact: contact,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),

            StatefulShellBranch(
              navigatorKey: _shellNavigatorKeyRequest,
              routes: [
                GoRoute(
                  path: AppRoutes.request,
                  name: AppRoutes.request,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: RequestScreen()),
                ),
              ],
            ),

            StatefulShellBranch(
              navigatorKey: _shellNavigatorKeyProfile,
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  name: AppRoutes.profile,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: ProfileScreen()),
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (context, state) => const EditProfileScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<CallBloc>.value(value: getIt<CallBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: _goRouter,
        title: 'Vanish Link',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        builder: (context, child) {
          return CallOverlayManager(child: child);
        },
      ),
    );
  }
}
