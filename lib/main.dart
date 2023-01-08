import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'Auth/Screens/Login/components/LogInBloc/login_bloc.dart';
import 'Auth/Screens/Signup/components/SignUpBloc/signup_bloc.dart';
import 'Auth/Screens/Welcome/welcome_screen.dart';
import 'Auth/constants.dart';
import 'cars_bloc/cars_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider extends InheritedWidget.
    return MultiProvider(
        providers: [
          // initialize cars bloc
          BlocProvider<CarsBloc>(
            create: (context) => CarsBloc(),
          ),
          // initialize cars login

          BlocProvider<LogInBloc>(
            create: (context) => LogInBloc(),
          ),
          // initialize cars signup

          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(),
          ),
        ],
        child: MaterialApp(
          // theme that is used in whole app
          theme: ThemeData(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: Colors.white,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: kPrimaryColor,
                  shape: const StadiumBorder(),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: kPrimaryLightColor,
                iconColor: kPrimaryColor,
                prefixIconColor: kPrimaryColor,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
              )),
// this is welcome screen where two option to start app login and signup
          home: const WelcomeScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
