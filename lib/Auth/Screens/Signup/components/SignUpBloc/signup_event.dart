part of 'signup_bloc.dart';

@immutable
abstract class SignUpEvent {}

// ignore: must_be_immutable
class SignUp extends SignUpEvent {
  String email;
  String password;

  SignUp({required this.email, required this.password});
}
