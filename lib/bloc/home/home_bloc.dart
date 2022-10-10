import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/lawyers_reponse.dart';
import '../repo/app_repo.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppRepository repo;
  HomeBloc({required this.repo}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeFetchDataEvent) {
        emit(HomeLoadingState());
        await repo.getLawyers().then((value) {
          emit(HomeLoadedState(lawyers: value));
        }).onError((error, stackTrace) {
          emit(HomeFailedState(message: error.toString()));
        });
      }
    });
  }
}
