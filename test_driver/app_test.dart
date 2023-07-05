import 'package:flutter_test/flutter_test.dart'
    show group, test, setUpAll, tearDownAll;
import 'package:flutter_driver/flutter_driver.dart';

void main() {
  group('Flutter Driver demo', () async {
    FlutterDriver driver = await FlutterDriver.connect();

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });
    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });
  });
}
