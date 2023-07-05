import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() => integrationDriver(onScreenshot:
        (String screenshotName, List<int> screenshotBytes,
            [Map<String, Object?>? _]) async {
      // Save the screenshot to disk.
      // ignore: avoid_print
      print('screenshot: $screenshotName');
      final file = File('$screenshotName.png');
      await file.writeAsBytes(screenshotBytes);
      return true;
    });
