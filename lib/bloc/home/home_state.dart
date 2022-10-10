part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Data> lawyers;

  HomeLoadedState({required this.lawyers});
}

class HomeFailedState extends HomeState {
  final String message;

  HomeFailedState({required this.message});
}
