import 'package:flutter/material.dart';

import '../Auth/constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      cursorColor: kPrimaryColor,
      onSaved: (email) {},
      decoration: InputDecoration(
        label: Text(hintText),
        labelStyle: const TextStyle(color: Colors.purple),
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(icon),
        ),
      ),
    );
  }
}
