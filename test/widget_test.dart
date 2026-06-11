import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vanish_link/features/auth/presentation/screens/splash_screen.dart';

class FakeAuthBloc extends Bloc<AuthEvent, AuthState> implements AuthBloc {
  FakeAuthBloc() : super(const AuthState.unauthenticated()) {
    on<AuthEvent>((event, emit) {});
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('Splash screen shows brand name and slogan', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: BlocProvider<AuthBloc>(
          create: (context) => FakeAuthBloc(),
          child: const SplashScreen(),
        ),
      ),
    );

    // Verify that the brand name and slogan are rendered correctly.
    expect(find.text('VanishLink'), findsOneWidget);
    expect(find.text('Ephemeral, secure, vanishing links'), findsOneWidget);
  });
}
