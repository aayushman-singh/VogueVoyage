import 'package:voguevoyage/utils/adjustments.dart';
import 'package:flutter/material.dart';
import 'package:voguevoyage/utils/user_provider.dart';
import 'screens/sign_up.dart';
import 'screens/login.dart';
import 'screens/splash.dart';
import 'screens/home.dart';
import 'package:voguevoyage/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:voguevoyage/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:voguevoyage/utils/selection.dart';
import 'package:voguevoyage/utils/image_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectionModel()),
        ChangeNotifierProvider(create: (_) => HomeModel()),
        ChangeNotifierProvider(create: (_) => BoxToApparelTypeMap()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vogue Voyage',
      theme: ThemeClass.lightTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context, {arguments}) => Home(initialPage: 1),
        '/user_input': (context, {arguments}) => UserPage(),
      },
    );
  }
}
