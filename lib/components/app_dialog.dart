import 'package:flutter/material.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/features/app_menu/view/cubit/app_menu_state.dart';

import 'custom_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({super.key, required this.state});

  final AppMenuState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: Container(
        width: 266,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border.all(color: AppColors.gray2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Result', style: theme.textTheme.titleMedium),
            const SizedBox(height: 20.0),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                children: [
                  Text(state.dialogCurrency, style: theme.textTheme.labelLarge),
                  const Expanded(child: SizedBox()),
                  Text('\$${state.dialogMoneyCount}'),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: state.dialogIsWon == true
                    ? AppColors.green.withOpacity(0.1)
                    : AppColors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '${state.dialogIsWon == true ? '+' : '-'}${state.dialogPoint}',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: state.dialogIsWon == true
                      ? AppColors.green
                      : AppColors.red,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              state.dialogIsWon == true
                  ? 'You made money on this deal.'
                  : 'You lose on this trade.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 48.0),
            SizedBox(
              width: 139,
              child: CustomButton(
                height: 38,
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Ok',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
