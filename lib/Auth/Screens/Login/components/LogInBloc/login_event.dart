part of 'login_bloc.dart';

@immutable
abstract class LogInEvent {}

// ignore: must_be_immutable
class LogIn extends LogInEvent {
  String email;
  String password;

  LogIn({required this.email, required this.password});
}
