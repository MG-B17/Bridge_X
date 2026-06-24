import 'package:bridge_x/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginResponseModel.fromJson', () {
    test('parses the new login response shape', () {
      final model = LoginResponseModel.fromJson({
        'message': 'Login successful.',
        'user': {
          'id': 22,
          'name': 'Mostafa Galal',
          'email': 'mostafagalal14152004@gmail.com',
          'user_name': 'mostafagalal_17',
          'role': 'programmer',
          'avatar_url': null,
          'is_verified': true,
          'fcm_token': 'token',
          'profile_completed': true,
          'track': 'flutter Developer',
          'bio': 'cs student',
          'experience_level': 'beginner',
          'total_score': 200,
        },
        'token': '44|8pgtiV81PL2bO5ToeMXQaIcEmKArmQDltwbbMAz6fbeabdf2',
        'token_type': 'Bearer',
      });
      expect(model.isProfileComplete, isTrue);
      expect(model.isVerified, isTrue);
      expect(model.userName, 'mostafagalal_17');

    });

    test('falls back to legacy wrapped login response shape', () {
      final model = LoginResponseModel.fromJson({
        'token': 'legacy-token',
        'data': {
          'user': {
            'id': 7,
            'name': 'Legacy User',
            'is_verified': 1,
            'is_profile_complete': 'true',
          },
        },
      });
      expect(model.isVerified, isTrue);
      expect(model.isProfileComplete, isTrue);
    });
  });
}
