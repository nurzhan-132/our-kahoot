// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/game_controller.dart';
import 'controllers/user_controller.dart';
import 'package:flutter/services.dart';
import 'views/menu/welcome_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserController.init();
  await GameController.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Login & Signup';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blue.shade300,
          unselectedWidgetColor: Colors.blue.shade200,
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(Colors.white),
          ),
          colorScheme: const ColorScheme.dark()
              .copyWith(secondary: Colors.indigoAccent.withOpacity(0.8)),
        ),
        home: const Welcome(),
      );
}
