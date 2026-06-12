import 'package:flutter/widgets.dart';

class CallLifecycleManager with WidgetsBindingObserver {
  final Function(AppLifecycleState) _onStateChanged;
  bool _isObserving = false;

  CallLifecycleManager(this._onStateChanged);

  void startObserving() {
    if (_isObserving) return;
    WidgetsBinding.instance.addObserver(this);
    _isObserving = true;
  }

  void stopObserving() {
    if (!_isObserving) return;
    WidgetsBinding.instance.removeObserver(this);
    _isObserving = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _onStateChanged(state);
  }
}
