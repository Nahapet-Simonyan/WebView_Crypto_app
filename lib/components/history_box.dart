import 'package:flutter/material.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/repositories/models/bet_model/bet_model.dart';

class HistoryBox extends StatelessWidget {
  const HistoryBox({super.key, required this.theme, required this.bet});

  final ThemeData theme;
  final BetModel bet;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              bet.type == 'up'
                  ? Image.asset('assets/icons/green_arrow_up.png')
                  : Image.asset('assets/icons/red_arrow_down.png'),
              const SizedBox(width: 12.0),
              Text(
                bet.currencyPair,
                style: const TextStyle(fontSize: 16),
              ),
              const Expanded(child: SizedBox()),
              Text(
                '${bet.isWon! ? '+' : '-'}\$${bet.amount + bet.amount / 10}',
                style: TextStyle(
                  fontSize: 16,
                  color: bet.isWon! ? AppColors.green : AppColors.red,
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.gray2, height: 1),
          Row(
            children: [
              Text(
                'Invested: ',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray3,
                ),
              ),
              Text('\$${bet.amount}', style: theme.textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
