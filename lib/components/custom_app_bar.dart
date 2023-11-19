import 'package:flutter/material.dart';

import 'package:bin7r4decl/core/constants/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);
    return Stack(
      children: [
        canPop
            ? Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.gray3,
                        size: 24,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        'Back',
                        style: TextStyle(fontSize: 17, color: AppColors.gray3),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
