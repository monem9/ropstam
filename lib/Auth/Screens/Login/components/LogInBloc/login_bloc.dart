import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'login_event.dart';

part 'login_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitial());

  @override
  Stream<LogInState> mapEventToState(
    LogInEvent event,
  ) async* {
    // here we call the email and password which are stored in mobile app store
    const storage = FlutterSecureStorage();
    var email = await storage.read(key: 'email');
    var password = await storage.read(key: 'password');

    if (event is LogIn) {
      yield LoginLoading();

      {
        try {
          // here is validation of log in text fields
          if (event.email == '') {
            yield ErrorState(error: 'Please Enter You Email');
          }
          else if (!event.email.contains('@')) {
            yield ErrorState(error: 'Please Enter Proper Email');
          }
          else if (!event.email.endsWith('.com')) {
            yield ErrorState(error: 'Please Enter Proper Email');
          }
          else if (event.password == '') {
            yield ErrorState(error: 'Please Enter You Password');
          } else if (event.email != email) {
            yield ErrorState(error: 'Your Email is not Correct');
          } else if (event.password != password) {
            yield ErrorState(error: 'Your Password is not Correct');
          } else {
            yield LogInSuccess(message: 'Successfully Logged In');
          }
          // ignore: empty_catches
        } catch (e) {}
      }
    }
  }
}
