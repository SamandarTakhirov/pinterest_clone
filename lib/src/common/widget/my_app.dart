import 'package:flutter/material.dart';

import '../../page/main/splash/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pinterest",
      theme: ThemeData(useMaterial3: true),
      home: const Splash(),
    );
  }
}
