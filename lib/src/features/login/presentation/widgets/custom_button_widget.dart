import 'package:flutter/material.dart';
import 'package:machine_test/src/utils/styles/app_colors.dart';
import 'package:machine_test/src/utils/styles/styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });

  final String title;
  final bool isLoading;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 231, 177, 15),
          borderRadius: BorderRadius.circular(84),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.white,
              ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: AppTextStyles.fBlack16_500),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.arrow_right_alt_rounded,
                    color: AppColors.black,
                  )
                ],
              ),
      ),
    );
  }
}
