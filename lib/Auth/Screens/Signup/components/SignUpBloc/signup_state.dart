part of 'signup_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpInitial extends SignUpState {}

// ignore: must_be_immutable
class ErrorState extends SignUpState {
  String error;

  ErrorState({required this.error});
}

// ignore: must_be_immutable
class SignUpSuccess extends SignUpState {
  String message;
  String email;
  String password;

  SignUpSuccess(
      {required this.message, required this.email, required this.password});
}
