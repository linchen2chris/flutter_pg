#!/bin/sh
flutter drive \
--driver=test_driver/integration_test.dart \
--target=integration_test/smock_test.dart \
-d web-server \
--no-pub \
--debug \
--no-headless