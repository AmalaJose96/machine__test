import 'package:flutter/material.dart';
import 'package:machine_test/src/features/login/domain/usecases/validators.dart';
import 'package:machine_test/src/utils/styles/app_colors.dart';
import 'package:machine_test/src/utils/styles/styles.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.errorText,
    required this.hintText,
    required this.inputType,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String errorText;
  final String hintText;
  final IconData? prefixIcon;
  final InputTypes inputType;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  void _viewPass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.fBlack16_500,
      obscureText:
          widget.inputType == InputTypes.phone ? _obscureText : false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (widget.inputType == InputTypes.phone) {
          return AuthHelpers().validatePassword(value ?? '');
        }
        if (widget.inputType == InputTypes.username) {
          return AuthHelpers().isUsernameValid(value ?? '');
        }

        return null;
      },
      controller: widget.controller,
      decoration: InputDecoration(
          hintStyle: AppTextStyles.fBlack16_500,
          prefixIcon: Icon(
            size: 20,
            widget.prefixIcon,
            color: AppColors.grey,
          ),
          suffixIcon: widget.inputType == InputTypes.phone
              ? GestureDetector(
                  onTap: () {
                    _viewPass();
                  },
                  child: Icon(
                    size: 20,
                    color: AppColors.black,
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
              
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          hintText: widget.hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.grey,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.grey,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.lightRed,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.lightRed,
              )),
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.white, width: .5),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}

enum InputTypes { username, email ,phone ,remarks,gender,visitedDate,purpose,visitedTime}
