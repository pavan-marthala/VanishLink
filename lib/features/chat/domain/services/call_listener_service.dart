import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/chat/domain/repositories/call_repository.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_bloc.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_event.dart';
import 'package:vanish_link/core/di/injection.dart';

class CallListenerService {
  final CallRepository _callRepository;
  final FirebaseAuth _auth;
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<CallModel?>? _callSubscription;

  CallListenerService({
    required CallRepository callRepository,
    FirebaseAuth? auth,
  })  : _callRepository = callRepository,
        _auth = auth ?? FirebaseAuth.instance;

  void startMonitoring() {
    _authSubscription = _auth.authStateChanges().listen((user) {
      if (user != null) {
        _listenForIncomingCalls(user.uid);
      } else {
        _stopListening();
      }
    });
  }

  void _listenForIncomingCalls(String userId) {
    _callSubscription?.cancel();
    _callSubscription = _callRepository.watchIncomingCalls(userId).listen(
      (dynamic incomingData) {
        if (incomingData == null) return;
        if (incomingData is! CallModel) {
          // Guard against raw Firebase payload / JS objects leaking through
          return;
        }
        final CallModel call = incomingData;
        final callBloc = getIt<CallBloc>();
        final hasActive = callBloc.state.maybeMap(
          calling: (_) => true,
          incomingCall: (_) => true,
          connecting: (_) => true,
          connected: (_) => true,
          active: (_) => true,
          orElse: () => false,
        );
        if (hasActive) {
          // Reject the call as busy because we are already in another call
          _callRepository.updateCallStatus(call.callId, 'busy');
          return;
        }
        // Update CallBloc status to start listening
        getIt<CallBloc>().add(CallEvent.listenToCall(call.callId));
        // If status is 'created', 'delivering', or 'calling', change to 'ringing' to signal to the caller we are ringing
        if (call.status == 'created' ||
            call.status == 'delivering' ||
            call.status == 'calling') {
          _callRepository.updateCallStatus(call.callId, 'ringing');
        }
      },
      onError: (dynamic error) {
        // Defensive stream exception handling to prevent infinite loops
      },
      cancelOnError: false,
    );
  }

  void _stopListening() {
    _callSubscription?.cancel();
    _callSubscription = null;
  }

  void stopMonitoring() {
    _authSubscription?.cancel();
    _stopListening();
  }
}
