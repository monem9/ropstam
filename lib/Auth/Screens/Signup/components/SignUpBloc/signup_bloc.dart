import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUp) {
      yield SignUpLoading();

      {
        try {
          // here is the validation of signup text fields
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
          } else {

            yield SignUpSuccess(
                message: 'Successfully Sign Up',
                email: event.email,
                password: event.password);
          }
          // ignore: empty_catches
        } catch (e) {}
      }
    }
  }
}
