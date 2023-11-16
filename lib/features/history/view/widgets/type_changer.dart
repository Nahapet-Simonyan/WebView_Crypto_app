import 'package:flutter/material.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/core/enums/history_type.dart';

import '../ui_cubit/history_state.dart';

class TypeChanger extends StatelessWidget {
  const TypeChanger({
    super.key,
    required this.state,
    required this.type,
    this.onTap,
  });

  final HistoryState state;
  final HistoryType type;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 7.0,
        ),
        decoration: BoxDecoration(
          border:
              state.type == type ? null : Border.all(color: AppColors.gray3),
          borderRadius: BorderRadius.circular(4.0),
          color: state.type == type ? AppColors.yellow : Colors.transparent,
        ),
        child: Center(
          child: Text(
            type.name[0].toUpperCase() + type.name.substring(1),
            style: theme.textTheme.titleSmall?.copyWith(
              color: state.type == type ? AppColors.black : AppColors.gray3,
            ),
          ),
        ),
      ),
    );
  }
}
