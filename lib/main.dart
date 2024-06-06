import 'package:firebase_core/firebase_core.dart';
import 'package:fivoza/config/routes/router.dart';
import 'package:fivoza/core/constants/colors.dart';
import 'package:fivoza/core/services/service_locator.dart' as locator;
import 'package:fivoza/firebase_options.dart';
import 'package:fivoza/presentation/blocs/auth/auth_bloc.dart';
import 'package:fivoza/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:fivoza/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await locator.serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator.sl<SignUpBloc>()),
        BlocProvider(create: (context) => locator.sl<SignInBloc>()),
        BlocProvider(create: (context) => locator.sl<AuthBloc>()),
      ],
      child: MaterialApp.router(
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
      ),
    );
  }
}
