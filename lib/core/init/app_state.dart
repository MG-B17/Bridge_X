import 'package:bridge_x/core/utils/models/user_data_model.dart';
import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  
  bool _isReady = false;
  bool _isLoggedIn = false;
  bool _hasSeenOnboarding = false;
  bool _isVerified = false;
  bool _isProfileComplete = false;
  UserDataModel? _userData;

  bool get isReady => _isReady;
  bool get isLoggedIn => _isLoggedIn;
  bool get hasSeenOnboarding => _hasSeenOnboarding;
  bool get isVerified => _isVerified;
  bool get isProfileComplete => _isProfileComplete;
  UserDataModel? get userData => _userData;

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

  set isProfileComplete(bool value) {
    if (_isProfileComplete != value) {
      _isProfileComplete = value;
      notifyListeners();
    }
  }

  set userData(UserDataModel? value) {
    if (_userData != value) {
      _userData = value;
      notifyListeners();
    }
  }

  void batchUpdate({
    bool? isLoggedIn,
    bool? isVerified,
    bool? isProfileComplete,
    UserDataModel? userData,
  }) {
    bool changed = false;
    if (isLoggedIn != null && _isLoggedIn != isLoggedIn) {
      _isLoggedIn = isLoggedIn;
      changed = true;
    }
    if (isVerified != null && _isVerified != isVerified) {
      _isVerified = isVerified;
      changed = true;
    }
    if (isProfileComplete != null && _isProfileComplete != isProfileComplete) {
      _isProfileComplete = isProfileComplete;
      changed = true;
    }
    if (userData != null && _userData != userData) {
      _userData = userData;
      changed = true;
    }
    if (changed) notifyListeners();
  }

  void reset() {
    _isReady = false;
    _isLoggedIn = false;
    _hasSeenOnboarding = false;
    _isVerified = false;
    _isProfileComplete = false;
    _userData = null;
    notifyListeners();
  }
}
