import 'package:flutter/material.dart';
import 'views/login_screen.dart';
import './views/game_creator_screen.dart';
import 'views/home_screen.dart';
import 'views/user_screen.dart';
import 'utils/user_preferences.dart';
import 'utils/user_simple_preferences.dart';
import 'package:flutter/services.dart';


// void main() => runApp(const OurKahoot());
//
// class OurKahoot extends StatelessWidget {
//   const OurKahoot({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: {
//         '/': (context) => const LoginScreen(),
//         RegistrationScreen.route: (context) => const RegistrationScreen(),
//         GameCreatorScreen.route: (context) => const GameCreatorScreen(),
//         LoginScreen.route: (context) => const LoginScreen(),
//       },
//       initialRoute: '/',
//     );
//     //return GameProvider(child: const MaterialApp(home: GameCreatorScreen()));
//   }
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Login & Signup';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      colorScheme: ColorScheme.dark(),
      scaffoldBackgroundColor: Colors.blue.shade300,
      accentColor: Colors.indigoAccent.withOpacity(0.8),
      unselectedWidgetColor: Colors.blue.shade200,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    home: HomeScreen(),
  );
}
