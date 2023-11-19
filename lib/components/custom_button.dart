import 'package:flutter/material.dart';

import 'package:bin7r4decl/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.height = 48.0,
    this.borderRadius = 4.0,
    this.color = AppColors.yellow,
    this.prefixIcon,
    this.suffixIcon,
    required this.child,
  });

  final void Function()? onTap;
  final double height;
  final double borderRadius;
  final Color color;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: suffixIcon == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              child,
              if (suffixIcon != null)
                Container(
                  width: 24.0,
                  height: 24.0,
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: suffixIcon,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
