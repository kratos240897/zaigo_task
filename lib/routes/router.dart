import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaigo_task/bloc/home/home_bloc.dart';
import 'package:zaigo_task/bloc/login/login_bloc.dart';
import 'package:zaigo_task/bloc/repo/app_repo.dart';
import 'package:zaigo_task/modules/home/home.dart';
import 'package:zaigo_task/modules/login/login.dart';

import 'routes.dart';

class PageRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      case Routes.LOGIN:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginBloc(repo: context.read<AppRepository>()),
            child: const Login(),
          ),
        );
      case Routes.HOME:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeBloc(repo: context.read<AppRepository>()),
            child: const Home(),
          ),
        );
    }
    return null;
  }
}
