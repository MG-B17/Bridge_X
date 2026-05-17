import 'package:flutter/foundation.dart';

/// Stores app state: is user logged in? Did they see onboarding? Is app ready?
class AppState extends ChangeNotifier {
  bool _isReady = false;
  bool _isLoggedIn = false;
  bool _hasSeenOnboarding = false;

  bool get isReady => _isReady;
  bool get isLoggedIn => _isLoggedIn;
  bool get hasSeenOnboarding => _hasSeenOnboarding;

  set isReady(bool value) {
    if (_isReady != value) {
      _isReady = value;
      notifyListeners();
    }
  }

  set isLoggedIn(bool value) {
    if (_isLoggedIn != value) {
      _isLoggedIn = value;
      notifyListeners();
    }
  }

  set hasSeenOnboarding(bool value) {
    if (_hasSeenOnboarding != value) {
      _hasSeenOnboarding = value;
      notifyListeners();
    }
  }

  void reset() {
    _isReady = false;
    _isLoggedIn = false;
    _hasSeenOnboarding = false;
    notifyListeners();
  }
}
