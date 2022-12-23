import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:institute_objectbox/app/app.dart';
import 'package:institute_objectbox/state/objectbox_state.dart';
import 'helper/objectbox.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await ObjectBoxInstance.deleteDatabase();
  // Create an Object for ObjectBoxInstance
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();

  // Disable landscape mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}
