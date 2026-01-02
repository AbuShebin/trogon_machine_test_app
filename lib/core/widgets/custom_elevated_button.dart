import 'package:flutter/material.dart';
import 'package:trogon_machine_test_app/core/constants/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Icon? icon;
  final double width;
  final double height;
  final Color? color;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.height,
    required this.width,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height * 0.06,
        width: width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.04),
          color: color ?? AppColors.primary,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
              icon ?? SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
