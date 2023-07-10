import 'dart:async';

import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pg/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // NEW

  testWidgets('load first page', (tester) async {
    await app.main();
    print('start pump settle');
    await tester.pumpAndSettle(const Duration(milliseconds: 100),
        EnginePhase.sendSemanticsUpdate, const Duration(seconds: 10));
    print('end pump settle');
  }, skip: true);

  testWidgets('pause', (tester) async {
    await app.main();
    await tester.pump(const Duration(seconds: 10));
    print('start pump');
    //await tester.pumpAndSettle(const Duration(milliseconds: 100),
    //    EnginePhase.sendSemanticsUpdate, const Duration(seconds: 10));
    print('end pump');
    print('start delay');
    await Future.delayed(const Duration(seconds: 10));
    print('end delay');
    print('start Timer');
    await pumpForSeconds(tester, 10);
    print('end Timer');
  });
}

Future<void> pumpForSeconds(WidgetTester tester, int seconds) async {
  bool timerDone = false;
  Timer.periodic(Duration(seconds: seconds), (timer) {
    timerDone = true;
  });
  while (timerDone != true) {
    await tester.pump();
  }
}
