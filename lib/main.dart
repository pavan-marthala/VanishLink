import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/routes/app_routes.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vanish_link/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:vanish_link/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:vanish_link/features/auth/presentation/screens/splash_screen.dart';
import 'package:vanish_link/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:vanish_link/features/chat/presentation/screens/chat_screen.dart';
import 'package:vanish_link/features/home/presentation/screens/home_screen.dart';
import 'package:vanish_link/features/profile/presentation/screens/profile_screen.dart';
import 'package:vanish_link/features/request/presentation/screens/request_screen.dart';
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

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();

  // Start checking authentication state
  getIt<AuthBloc>().add(const AuthEvent.started());

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
                      NoTransitionPage(child: ChatScreen()),
                  routes: [
                    GoRoute(
                      path: AppRoutes.chatDetails,
                      builder: (context, state) => const ChatDetailsScreen(),
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
                      NoTransitionPage(child: RequestScreen()),
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
                      NoTransitionPage(child: ProfileScreen()),
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
    return BlocProvider<AuthBloc>.value(
      value: _authBloc,
      child: MaterialApp.router(
        routerConfig: _goRouter,
        title: 'Vanish Link',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        builder: (context, child) {
          return child ?? const Text('child');
        },
      ),
    );
  }
}
