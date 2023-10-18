import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/olearis_bloc.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  LoginDemoState createState() => LoginDemoState();
}

class LoginDemoState extends State<LoginDemo> {
  bool autoValidateModeOn = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _emailFormValidator() {
    if (emailController.text.isEmpty) {
      return "Please enter valid email";
    } else {
      return null;
    }
  }

  String? _passwordFormValidator() {
    if (passwordController.text.isEmpty) {
      return "Please enter valid password";
    } else {
      return null;
    }
  }

  void _onEmailFieldSubmitted(BuildContext context, String value) {
    setState(() {
      emailController.text = value;
      autoValidateModeOn = true;
    });
    final _ = BlocProvider.of<OlearisBloc>(context).add(
      OlearisEmailSubmitted(
        emailValue: value,
      ),
    );
  }

  void _onPasswordFieldSubmitted(BuildContext context, String value) {
    setState(() {
      passwordController.text = value;
      autoValidateModeOn = true;
    });
    final _ = BlocProvider.of<OlearisBloc>(context).add(
      OlearisPasswordSubmitted(
        passwordValue: value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            autovalidateMode: autoValidateModeOn
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction,
            controller: emailController,
            onChanged: (value) => _onEmailFieldSubmitted(context, value),
            validator: (value) => _emailFormValidator(),
            decoration: InputDecoration(
              errorBorder: _errorBorder(),
              focusedErrorBorder: _errorBorder(),
              border: const OutlineInputBorder(),
              labelText: 'Email',
              hintText: 'example@mail.com',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 15,
          ),
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            autovalidateMode: autoValidateModeOn
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction,
            controller: passwordController,
            onChanged: (value) => _onPasswordFieldSubmitted(context, value),
            validator: (value) => _passwordFormValidator(),
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: 'Enter password',
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _errorBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    );
  }
}
