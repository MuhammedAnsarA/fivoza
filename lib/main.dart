import 'package:firebase_core/firebase_core.dart';
import 'package:fivoza/config/routes/router.dart';
import 'package:fivoza/core/constants/colors.dart';
import 'package:fivoza/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fivoza',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.primary,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.secondary,
          selectionHandleColor: AppColors.secondary,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      routerConfig: goRouter,
    );
  }
}
