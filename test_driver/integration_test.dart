import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() => integrationDriver(onScreenshot:
        (String screenshotName, List<int> screenshotBytes,
            [Map<String, Object?>? args]) async {
      // Save the screenshot to disk.
      if (args != null) {
        final String? someArgumentValue = args['someArgumentKey'] as String?;
        return someArgumentValue != null;
      }
      // ignore: avoid_print
      print('screenshot: $screenshotName');
      final file = File('$screenshotName.png');
      await file.writeAsBytes(screenshotBytes);
      return false;
    });
