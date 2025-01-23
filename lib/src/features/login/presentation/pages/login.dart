import 'package:flutter/material.dart';
import 'package:machine_test/src/features/login/presentation/pages/login_widget.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final timecontroller = TextEditingController();
  final purposecontroller = TextEditingController();
   final emailcontroller = TextEditingController();
   final gendercontroller = TextEditingController();
   final datecontroller = TextEditingController();
    final remarkcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoginBodyWidget(
            formKey: _formKey,
            usernameController: namecontroller,
            phonescontroller :phonecontroller,
            timescontroller: timecontroller,
            purposescontroller : purposecontroller,
            emailscontroller : emailcontroller,
            genderscontroller : gendercontroller,
            datescontroller: datecontroller,
            remarkscontroller : remarkcontroller,
            ));
  }
}
