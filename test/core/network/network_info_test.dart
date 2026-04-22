import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:bridgex/core/network/network_info.dart';

class MockInternetConnection extends Mock implements InternetConnection {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnection mockInternetConnection;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    networkInfo = NetworkInfoImpl(mockInternetConnection);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnection.hasInternetAccess', () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(() => mockInternetConnection.hasInternetAccess)
          .thenAnswer((_) => tHasConnectionFuture);
      
      // act
      final result = networkInfo.isConnected;
      
      // assert
      verify(() => mockInternetConnection.hasInternetAccess);
      expect(result, tHasConnectionFuture);
    });
  });
}
