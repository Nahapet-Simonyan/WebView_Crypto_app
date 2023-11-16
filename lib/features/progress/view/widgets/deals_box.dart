import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bin7r4decl/core/constants/colors.dart';

class DealsBox extends StatelessWidget {
  const DealsBox({
    super.key,
    required this.item,
    required this.asState,
  });

  final Map<String, dynamic> item;
  final num asState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Name',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.gray3,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(item['name'], style: theme.textTheme.headlineMedium),
          const SizedBox(height: 16.0),
          Text(
            asState.toInt() < item['max'].toInt()
                ? '${asState.toInt()}/${item['max'].toInt()} deals'
                : '${item['max'].toInt()}/${item['max'].toInt()} deals',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.gray3,
            ),
          ),
          const SizedBox(height: 4.0),
          LinearProgressIndicator(
            backgroundColor: AppColors.gray2,
            color: AppColors.yellow,
            borderRadius: BorderRadius.circular(27),
            value: asState / item['max'].toInt(),
          ),
          const SizedBox(height: 16.0),
          const Divider(color: AppColors.gray2, height: 1),
          const SizedBox(height: 12.0),
          Text(
            'Reward',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.gray3,
            ),
          ),
          Text(
            '${NumberFormat.decimalPattern().format(item['reward'].toInt()).toString().replaceAll(',', '.')} points',
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
