import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';
import 'package:image_compare/image_compare.dart';

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
      // Compare the screenshot to a golden image.
      final goldenFile = File('$screenshotName.golden.png');
      var result = await compareImages(
          src1: file,
          src2: goldenFile,
          algorithm: PixelMatching(ignoreAlpha: true, tolerance: 0.01));
      print('the difference is $result');
      return result < 0.5;
    });
