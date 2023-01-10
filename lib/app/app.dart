import 'package:flutter/material.dart';
import 'package:institute_objectbox/app/routes.dart';
import 'package:institute_objectbox/app/theme.dart';
import 'package:institute_objectbox/screen/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student course ObjectBox',
      debugShowCheckedModeBanner: false,
      theme: getApplicationThemeData(),
      initialRoute: LoginScreen.route,
      routes: getAppRoutes,
    );
  }
}
