import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/core/enums/achievement_type.dart';
import 'package:bin7r4decl/features/progress/achievements/achievements.dart';
import 'package:bin7r4decl/features/progress/view/cubit/progress_cubit.dart';

import 'progress_details_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProgressCubit, ProgressState>(
      builder: (context, state) {
        final formattedDoneProgress = NumberFormat.decimalPattern()
            .format(state.point)
            .replaceAll(',', '.');
        final formattedFullProgress = NumberFormat.decimalPattern()
            .format(state.fullProgress)
            .replaceAll(',', '.');
        double percentage = (state.point / state.fullProgress);
        context.read<ProgressCubit>().initial();
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 107,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Level: ',
                            style: theme.textTheme.headlineMedium,
                          ),
                          Text(
                            state.level.toString(),
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: AppColors.yellow,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$formattedDoneProgress / $formattedFullProgress',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.gray3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        backgroundColor: AppColors.gray2,
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(27),
                        value: percentage,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Achievements',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 100,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemCount: achievements.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = achievements[index];
                      num asState;
                      if (item['type'] == AchievementType.deal) {
                        asState = state.deal;
                      } else if (item['type'] ==
                          AchievementType.successfulDeal) {
                        asState = state.successfulDeal;
                      } else {
                        asState = state.binding;
                      }
                      if (asState < item['max']) {
                        return _NotFinishedAchievement(
                          item: item,
                          asState: asState,
                        );
                      }
                      return _FinishedAchievement(
                        item: item,
                        asState: asState,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NotFinishedAchievement extends StatelessWidget {
  const _NotFinishedAchievement({
    required this.item,
    required this.asState,
  });

  final Map<String, dynamic> item;
  final num asState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProgressDetails(item: item, asState: asState),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item['name'],
              style: theme.textTheme.titleMedium,
            ),
            const Expanded(child: SizedBox()),
            Text(
              '${asState.toInt()}/${item['max'].toInt()} deals',
              style: theme.textTheme.bodySmall?.copyWith(
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
          ],
        ),
      ),
    );
  }
}

class _FinishedAchievement extends StatelessWidget {
  const _FinishedAchievement({
    required this.item,
    required this.asState,
  });

  final Map<String, dynamic> item;
  final num asState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProgressDetails(
            item: item,
            asState: asState,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.yellow,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item['name'],
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.black,
              ),
            ),
            Text(
              '${NumberFormat.decimalPattern().format(item['reward'].toInt()).toString().replaceAll(',', '.')} points',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.gray1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
