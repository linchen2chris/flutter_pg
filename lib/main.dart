import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'animated_widget.dart';

class EnvironmentVariables {
  EnvironmentVariables({this.testUser});

  factory EnvironmentVariables.fromEnv(DotEnv dotenv) {
    print('environ');
    print(const String.fromEnvironment('TEST_USER'));
    print('dotenv');
    print(dotenv.env['TEST_USER']);
    return EnvironmentVariables(
        testUser: const String.fromEnvironment(
      'TEST_USER',
    ).isNotEmpty
            ? const String.fromEnvironment('TEST_USER')
            : dotenv.env['TEST_USER']);
  }

  final String? testUser;
}

late EnvironmentVariables env;

Future<void> main() async {
  await dotenv.load();
  env = EnvironmentVariables.fromEnv(dotenv);
  print('==================================');
  print(env.testUser);
  runApp(const MyApp());
}

class MyData {
  final String value;

  MyData(this.value);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<MyData>(create: (_) => MyData('Hello World')),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  double containerWidth = 100;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<MyData>(context, listen: false);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              key: Key('goldenTest'),
              'You have clicked the button this many many many times:',
            ),
            Text(key: const Key('testTextState'), data.value),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Center(
              child: Container(
                key: const Key('testWidgetState'),
                height: containerWidth,
                width: containerWidth,
                color: Colors.redAccent,
                child: GestureDetector(
                  onTap: () {
                    print('Container clicked');
                    setState(() {
                      // Animate the container's width to 200.
                      containerWidth = 200;
                    });
                  },
                ),
              ),
            ),
            ExampleInfiniteAnimation(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
