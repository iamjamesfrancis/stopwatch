import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stopwatch/stopwatch.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Stopwatch',
      debugShowCheckedModeBanner: false,
      home: StopwatchHome(),
    );
  }
}
