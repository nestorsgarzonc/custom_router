import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: HomeScreen.route,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        log('Navigating to: ${settings.name}');
        log('Arguments: ${settings.arguments.toString()}');
        switch (settings.name) {
          case HomeScreen.route:
            return MaterialPageRoute(
              builder: (context) => HomeScreen(),
            );
          case TestScreen.route:
            final args = settings.arguments as TestScreenArgs;
            return MaterialPageRoute(
              builder: (context) => TestScreen(
                name: args.name,
                reqioredName: args.reqioredName,
                optionalName: args.optionalName,
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => NotFoundScreen(),
            );
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  static const route = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Initial screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Custom navigator by NW'),
          const SizedBox(width: double.maxFinite, height: 10),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(
              TestScreen.route,
              arguments: TestScreenArgs(reqioredName: 'I\'m required'),
            ),
            child: const Text('Push with params'),
          ),
          const SizedBox(width: double.maxFinite, height: 10),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed(
              TestScreen.route,
              arguments: TestScreenArgs(reqioredName: 'Now I\'m the main route'),
            ),
            child: const Text('Replace with params'),
          ),
          const SizedBox(width: double.maxFinite, height: 10),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(
              'TestScreen.route',
            ),
            child: const Text('Go to not existing route'),
          ),
        ],
      ),
    );
  }
}

class TestScreenArgs {
  final String? name;
  final String optionalName;
  final String reqioredName;

  TestScreenArgs({
    this.name,
    this.optionalName = 'optional',
    required this.reqioredName,
  });

  @override
  String toString() =>
      'TestScreenArgs(name: $name, optionalName: $optionalName, reqioredName: $reqioredName)';
}

class TestScreen extends StatelessWidget {
  static const route = 'TestScreen';
  final String? name;
  final String optionalName;
  final String reqioredName;

  const TestScreen({
    Key? key,
    this.name,
    this.optionalName = 'optional',
    required this.reqioredName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page with params')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.maxFinite),
          Text('name: $name'),
          Text('optionalName: $optionalName'),
          Text('reqioredName: $reqioredName'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Go back'),
          )
        ],
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Screen not found :c'),
          const SizedBox(height: 10, width: double.maxFinite),
          ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text('Go back'))
        ],
      ),
    );
  }
}
