import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:zaigo_task/bloc/repo/app_repo.dart';
import 'package:zaigo_task/data/prefs.dart';
import 'package:zaigo_task/helpers/constants.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppRepository repo;
  LoginBloc({required this.repo}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginInitEvent) {
        emit(LoginLoadingState());
        await repo.login(event.email, event.password).then((value) async {
          await SharedPrefHelper().set(Constants.ACCESS_TOKEN_KEY, value);
          emit(LoginSuccessState());
        }).onError((error, stackTrace) {
          emit(LoginFailState(message: error.toString()));
        });
      }
    });
  }
}
