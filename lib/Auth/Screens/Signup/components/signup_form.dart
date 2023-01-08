import 'package:flutter/material.dart';

import '../../../../Widgets/text_field.dart';
import '../../../../Widgets/model_progress_hub.dart';
import '../../../../Widgets/toast.dart';
import '../../../components/already_have_an_account_check.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'SignUpBloc/signup_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SignUpBloc _signUpBloc;

  saveSignUp(String email, String password) async {
    // here we store email and password of sign up
    const storage = FlutterSecureStorage();
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);
  }

  @override
  void initState() {
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
      if (state is SignUpLoading) {
      } else if (state is ErrorState) {
        ToastClass().toastFunction(Colors.red, state.error);
      } else if (state is SignUpSuccess) {
        ToastClass().toastFunction(Colors.green, state.message);
        saveSignUp(state.email, state.password);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
          inAsyncCall: state is SignUpLoading,
          child: Form(
            child: Column(
              children: [
                TextFieldWidget(
                  controller: emailController,
                  hintText: 'Your Email',
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
                const SizedBox(height: defaultPadding / 2),
                ElevatedButton(
                  onPressed: () {
                    _signUpBloc.add(SignUp(
                        email: emailController.text,
                        password: passwordController.text));
                  },
                  child: Text("Sign Up".toUpperCase()),
                ),
                const SizedBox(height: defaultPadding),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
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
