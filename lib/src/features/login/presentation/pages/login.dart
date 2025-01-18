import 'package:flutter/material.dart';
import 'package:machine_test/src/features/login/presentation/pages/login_widget.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoginBodyWidget(
            formKey: _formKey,
            usernameController: emailcontroller,
            passwordcontroller: passwordcontroller));
  }
}
