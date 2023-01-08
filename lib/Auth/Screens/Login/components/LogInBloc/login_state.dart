part of 'login_bloc.dart';

@immutable
abstract class LogInState {}

class LoginLoading extends LogInState {}

class LogInInitial extends LogInState {}

// ignore: must_be_immutable
class ErrorState extends LogInState {
  String error;

  ErrorState({required this.error});
}

// ignore: must_be_immutable
class LogInSuccess extends LogInState {
  String message;

  LogInSuccess({required this.message});
}
