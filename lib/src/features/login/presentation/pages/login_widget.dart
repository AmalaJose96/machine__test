import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/src/features/home/presentation/pages/home.dart';
import 'package:machine_test/src/features/login/data/models/login_request.dart';
import 'package:machine_test/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:machine_test/src/features/login/presentation/widgets/custom_button_widget.dart';
import 'package:machine_test/src/features/login/presentation/widgets/textformfield_widget.dart';
import 'package:machine_test/src/utils/constants/app_constants.dart';
import 'package:machine_test/src/utils/helpers/extentions.dart';
import 'package:machine_test/src/utils/styles/styles.dart';
import 'package:machine_test/src/utils/toasters/toast.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.usernameController,
    required this.passwordcontroller,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController usernameController;

  final TextEditingController passwordcontroller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailedState) {
            showToast(state.error);
          }
          if (state is LoginSuccessState) {
            usernameController.clear();
            passwordcontroller.clear();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Home(
                          name: state.response?.name ?? '',
                        )));
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.height,
                  Image.asset(
                    'assets/icon.png',
                    height: 100,
                    width: 100,
                  ),
                  const Spacer(),
                  TextFormFieldWidget(
                    prefixIcon: Icons.person_2_outlined,
                    controller: usernameController,
                    errorText: StringConstants.usernameError,
                    hintText: StringConstants.username,
                    inputType: InputTypes.username,
                  ),
                  20.height,
                  TextFormFieldWidget(
                    prefixIcon: Icons.lock_outline,
                    controller: passwordcontroller,
                    errorText: StringConstants.passworderror,
                    hintText: StringConstants.password,
                    inputType: InputTypes.password,
                  ),
                  15.height,
                  const Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        StringConstants.forgotPassword,
                        style: AppTextStyles.fGrey14_500,
                      )),
                  15.height,
                  PrimaryButton(
                      isLoading: state is LoginLoadingState,
                      title: StringConstants.buttonText,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(OnLoginEvent(
                              loginRequest: LoginRequest(
                                  username: usernameController.text.trim(),
                                  password: passwordcontroller.text.trim())));
                        }
                      }),
                  15.height,
                  const Text.rich(
                    TextSpan(
                      text: StringConstants.noAccount,
                      style: AppTextStyles.fGrey14_500,
                      children: <TextSpan>[
                        TextSpan(
                            text: StringConstants.signUp,
                            style: AppTextStyles.fRed16_500),
                      ],
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
