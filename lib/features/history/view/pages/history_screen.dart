import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bin7r4decl/components/custom_button.dart';
import 'package:bin7r4decl/components/history_box.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/core/enums/history_type.dart';
import 'package:bin7r4decl/features/app_menu/view/cubit/app_menu_cubit.dart';
import 'package:bin7r4decl/features/history/view/ui_cubit/history_cubit.dart';
import 'package:bin7r4decl/features/history/view/widgets/currentBox.dart';

import '../ui_cubit/history_state.dart';
import '../widgets/type_changer.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.appMenuCubit});

  final AppMenuCubit appMenuCubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        final cubit = context.read<HistoryCubit>();
        cubit.getBets();
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  TypeChanger(
                    state: state,
                    type: HistoryType.current,
                    onTap: () {
                      if (state.type != HistoryType.current) {
                        cubit.changeHistoryType(HistoryType.current);
                      }
                    },
                  ),
                  const SizedBox(width: 8.0),
                  TypeChanger(
                    state: state,
                    type: HistoryType.finished,
                    onTap: () {
                      if (state.type != HistoryType.finished) {
                        cubit.changeHistoryType(HistoryType.finished);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              if (state.type == HistoryType.current)
                state.currentBets == null || state.currentBets!.isEmpty
                    ? _EmptyBets(theme: theme, appMenuCubit: appMenuCubit)
                    : Expanded(
                        child: ListView.separated(
                          itemCount: state.currentBets!.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 16.0,
                          ),
                          itemBuilder: (context, index) {
                            return CurrentBox(
                              theme: theme,
                              bet: state.currentBets![index],
                            );
                          },
                        ),
                      ),
              if (state.type == HistoryType.finished)
                state.finishedBets == null || state.finishedBets!.isEmpty
                    ? _EmptyBets(theme: theme, appMenuCubit: appMenuCubit)
                    : Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: state.finishedBets!.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 16.0,
                          ),
                          itemBuilder: (context, index) {
                            return HistoryBox(
                              theme: theme,
                              bet: state.finishedBets![index],
                            );
                          },
                        ),
                      ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyBets extends StatelessWidget {
  const _EmptyBets({required this.theme, required this.appMenuCubit});

  final ThemeData theme;
  final AppMenuCubit appMenuCubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/chart_bar.png'),
            const SizedBox(height: 24.0),
            Text(
              'There are no History',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 6.0),
            Text(
              'Start trading on our simulator',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.gray4,
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: 108,
              height: 38,
              child: CustomButton(
                onTap: () {
                  appMenuCubit.setSelectedItem(1);
                },
                child: Text(
                  'Trade',
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
