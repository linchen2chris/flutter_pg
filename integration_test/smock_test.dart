import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pg/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pg/main.dart' as app;
import 'package:provider/provider.dart';

void main() {
  final binding =
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
    await pumpForSeconds(tester, 2);
    print('end Timer');
    print('start pumpUntil');
    final found = await pumpUntilFound(
        tester, find.byKey(const Key('non-exit')),
        timeout: const Duration(seconds: 2));
    expect(found, true, reason: 'did not find');
  }, skip: false);

  testWidgets('Test Provider Data', (WidgetTester tester) async {
    print("hello------------------------, a new test");
    await app.main();
    await tester.pumpAndSettle();
    print('start context=============');
    final data = Provider.of<MyData>(
        tester.firstElement(find.byType(MyHomePage)),
        listen: false);
    print('data:      ${data.value}');
    expect(data.value, equals('Hello World'));

    await pumpForSeconds(tester, 10);
    print('start state ============');
    var state = tester.state<MyHomePageState>(find.byType(MyHomePage));
    print('state:    ${state.containerWidth}, ${state.counter}');
    await pumpForSeconds(tester, 10);
    await tester.tap(find.byTooltip('Increment'));
    print('new state:    ${state.containerWidth}, ${state.counter}');
    await pumpForSeconds(tester, 10);
    print('build contest ==============');
    var context = tester.element(find.byType(MyHomePage));
    print('context:    ${context.widget}');
  }, skip: true);

  testWidgets('Golden test', (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();
    try {
      await binding.takeScreenshot('GoldenTest-Text');
      print('=======+++++++++++++++++++++++++++++++++');
      // can't attach diff image here
    } catch (e) {
      // screenshot failed or return false
      // we could attach the diff here. and make test fail
      print('error: $e');
      throw ('current screenshot is different');
    } finally {
      print('attach diff image');
    }
    await pumpForSeconds(tester, 14);
  }, skip: true);

  testWidgets('test environment', (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();
    print('====================${env.testUser}');
    await pumpForSeconds(tester, 14);
  }, skip: true);
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

Future<bool> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 30),
}) async {
  bool timerDone = false;
  final timer = Timer.periodic(timeout, (timer) {
    timerDone = true;
  });
  while (timerDone != true) {
    await tester.pump();

    final found = tester.any(finder);
    if (found) {
      timerDone = true;
      timer.cancel();
      return true;
    }
  }
  timer.cancel();
  return false;
}
