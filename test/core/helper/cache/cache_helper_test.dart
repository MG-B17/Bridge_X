import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bridgex/core/helper/cache/cache_helper.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late CacheHelperImpl cacheHelper;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    cacheHelper = CacheHelperImpl(sharedPreferences: mockSharedPreferences);
  });

  group('saveToken', () {
    const tToken = 'test_token';

    test('should call SharedPreferences to cache the data', () async {
      // arrange
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);
      
      // act
      final result = await cacheHelper.saveToken(tToken);
      
      // assert
      verify(() => mockSharedPreferences.setString('auth_token', tToken));
      expect(result, true);
    });
  });

  group('getToken', () {
    const tToken = 'test_token';

    test('should return token from SharedPreferences when there is one in the cache', () {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(tToken);
      
      // act
      final result = cacheHelper.getToken();
      
      // assert
      verify(() => mockSharedPreferences.getString('auth_token'));
      expect(result, tToken);
    });

    test('should return null when there is no token in the cache', () {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      
      // act
      final result = cacheHelper.getToken();
      
      // assert
      verify(() => mockSharedPreferences.getString('auth_token'));
      expect(result, null);
    });
  });

  group('deleteToken', () {
    test('should call SharedPreferences to remove the data', () async {
      // arrange
      when(() => mockSharedPreferences.remove(any()))
          .thenAnswer((_) async => true);
      
      // act
      final result = await cacheHelper.deleteToken();
      
      // assert
      verify(() => mockSharedPreferences.remove('auth_token'));
      expect(result, true);
    });
  });
}
