import 'package:flutter/material.dart';
import 'package:bin7r4decl/components/custom_button.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/core/enums/betting_status.dart';

class StatusDialog extends StatelessWidget {
  const StatusDialog({super.key, required this.status});

  final BettingStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == BettingStatus.zeroBalance) {
      return AlertDialog(
        title: const Center(
          child: Text(
            "Your balance is zero",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        content: const Text(
          "Your progress and balance will be reset to defaults",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.black, fontSize: 13),
        ),
        actions: [
          Column(
            children: [
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }

    return AlertDialog(
      backgroundColor: AppColors.lightGrey,
      surfaceTintColor: Colors.transparent,
      title: Center(child: fetchStatusTitle()),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          children: [
            const Divider(color: AppColors.gray2, height: 1),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 100,
              height: 38,
              child: CustomButton(
                color: Colors.transparent,
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.black,
                      ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Text fetchStatusTitle() {
    switch (status) {
      case BettingStatus.success:
        return const Text(
          "Your bid has been accepted",
          style: TextStyle(color: AppColors.gray1, fontSize: 17),
        );
      case BettingStatus.zeroBalance:
        return const Text(
          "Your balance is zero",
          style: TextStyle(color: AppColors.red, fontSize: 17),
        );
      case BettingStatus.notEnough:
        return const Text(
          "Please enter correct amount",
          style: TextStyle(color: AppColors.red, fontSize: 17),
        );
      case BettingStatus.error:
        return const Text(
          "Something went wrong",
          style: TextStyle(color: AppColors.red, fontSize: 17),
        );
    }
  }
}
