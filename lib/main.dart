import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loggy/loggy.dart';
import 'package:zaigo_task/bloc/repo/app_repo.dart';
import 'package:zaigo_task/helpers/constants.dart';
import 'package:zaigo_task/helpers/styles.dart';
import 'package:zaigo_task/routes/router.dart';
import 'package:zaigo_task/routes/routes.dart';
import 'package:zaigo_task/service/api_service.dart';

import 'data/prefs.dart';

void main() async {
  final widgetsFlutterBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsFlutterBinding);
  await SharedPrefHelper().init();
  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    checkAuthenticationStatus();
    super.initState();
  }

  checkAuthenticationStatus() {
    isLoggedIn =
        SharedPrefHelper().get(Constants.ACCESS_TOKEN_KEY)?.isNotEmpty ?? false;
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppRepository(apiService: ApiService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zaigo Task',
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          primarySwatch: Styles.primaryColor,
        ),
        initialRoute: isLoggedIn ? Routes.HOME : Routes.LOGIN,
        onGenerateRoute: PageRouter.onGenerateRoute,
      ),
    );
  }
}
