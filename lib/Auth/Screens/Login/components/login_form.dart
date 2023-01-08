import 'package:flutter/material.dart';

import '../../../../Widgets/text_field.dart';
import '../../../../Widgets/toast.dart';
import '../../../../home_page.dart';
import '../../../../Widgets/model_progress_hub.dart';
import '../../../components/already_have_an_account_check.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'LogInBloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late LogInBloc _logInBloc;

  @override
  void initState() {
    _logInBloc = BlocProvider.of<LogInBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInBloc, LogInState>(listener: (context, state) {
      if (state is LoginLoading) {
      } else if (state is ErrorState) {
        ToastClass().toastFunction(Colors.red, state.error);
      } else if (state is LogInSuccess) {
        ToastClass().toastFunction(Colors.green, state.message);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          child: Form(
            child: Column(
              children: [
                TextFieldWidget(
                  controller: emailController,
                  hintText: 'Your email',
                  icon: Icons.person,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFieldWidget(
                    controller: passwordController,
                    hintText: 'Your password',
                    icon: Icons.lock,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Hero(
                  tag: "login_btn",
                  child: ElevatedButton(
                    onPressed: () {
                      _logInBloc.add(LogIn(
                          email: emailController.text,
                          password: passwordController.text));
                    },
                    child: Text(
                      "Login".toUpperCase(),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ));
    });
  }
}
