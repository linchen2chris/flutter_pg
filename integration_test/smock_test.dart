import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pg/main.dart' as app;
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // NEW

  testWidgets('load first page', (tester) async {
    app.main();
    await tester.pumpAndSettle();
  });

  // testWidgets("reproduce twice issue", (tester) async {
  //   var client = http.Client();
  //   await client.get(Uri.parse("http://localhost:9615/"), headers: {
  //     "Content-Type": "application/json",
  //     "Access-Control-Allow-Origin": "*",
  //   });
  // });
  //
  test('pause', () {});
}
