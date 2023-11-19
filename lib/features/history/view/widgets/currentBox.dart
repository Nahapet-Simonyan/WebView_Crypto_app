import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/features/simulator/data/data.dart';


class CurrentBox extends StatelessWidget {
  const CurrentBox({super.key, required this.theme, required this.bet});

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
                '\$${bet.amount}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const Divider(color: AppColors.gray2, height: 1),
          Row(
            children: [
              Text(
                'Left: ',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray3,
                ),
              ),
              StreamBuilder<DateTime>(
                  stream: Stream.periodic(const Duration(seconds: 1), (index) {
                    return DateTime.now();
                  }),
                  builder: (context, snapshot) {
                    Duration difference = bet.endTime.difference(DateTime.now());
                    int minutes = difference.inMinutes.remainder(60);
                    int seconds = difference.inSeconds.remainder(60);
                    String formattedDifference =
                        '${minutes.toString().padLeft(2, '0')}'
                        ':${seconds.toString().padLeft(2, '0')}';
                    if(difference.inSeconds < 0) {
                      GetIt.I<BettingRepository>().saveOrUpdateBet(
                        BetModel(
                          currencyPair: bet.currencyPair,
                          amount: bet.amount,
                          type: bet.type,
                          startTime: bet.startTime,
                          endTime: bet.endTime,
                          isFinished: true,
                          isWon: Random().nextBool(),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Text(
                        formattedDifference,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.yellow,
                        ),
                      );
                    } else {
                      return Text(
                        '',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.yellow,
                        ),
                      );
                    }
                  }),
              const Expanded(child: SizedBox()),
              Text(
                'Deal time: ',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray3,
                ),
              ),
              Text(
                DateFormat.Hm().format(bet.startTime),
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
