import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  
  bool _isReady = false;
  bool _isLoggedIn = false;
  bool _hasSeenOnboarding = false;
  bool _isVerified = false;
  bool _trackSelectionCompleted = false;
  bool _isProfileComplete = false;
  String? _username;

  bool get isReady => _isReady;
  bool get isLoggedIn => _isLoggedIn;
  bool get hasSeenOnboarding => _hasSeenOnboarding;
  bool get isVerified => _isVerified;
  bool get trackSelectionCompleted => _trackSelectionCompleted;
  bool get isProfileComplete => _isProfileComplete;
  String? get username => _username;

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

  set isVerified(bool value) {
    if (_isVerified != value) {
      _isVerified = value;
      notifyListeners();
    }
  }

  set trackSelectionCompleted(bool value) {
    if (_trackSelectionCompleted != value) {
      _trackSelectionCompleted = value;
      notifyListeners();
    }
  }

  set isProfileComplete(bool value) {
    if (_isProfileComplete != value) {
      _isProfileComplete = value;
      notifyListeners();
    }
  }

  set username(String? value) {
    if (_username != value) {
      _username = value;
      notifyListeners();
    }
  }

  void reset() {
    _isReady = false;
    _isLoggedIn = false;
    _hasSeenOnboarding = false;
    _isVerified = false;
    _trackSelectionCompleted = false;
    _isProfileComplete = false;
    _username = null;
    notifyListeners();
  }
}
