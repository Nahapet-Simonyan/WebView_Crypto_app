import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import '../bloc/betting_cubit/betting_cubit.dart';
import 'betting_helper_widgets/timer_amount_row.dart';
import 'betting_helper_widgets/up_down_buttons.dart';
import 'betting_helper_widgets/releted_bar.dart';

class BettingWidget extends StatelessWidget {
  final String? currency;

  const BettingWidget({
    super.key,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BettingCubit, BettingState>(
      builder: (context, state) {
        final cubit = context.read<BettingCubit>();
        final theme = Theme.of(context);
        return Container(
          height: 248,
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                /// Related bar
                RelatedBarWidget(
                  downRatePercentage: state.downRatePercentage,
                ),
                const SizedBox(height: 16),

                /// Balance
                Row(
                  children: [
                    Image.asset("assets/icons/yellow_wallet.png"),
                    const SizedBox(width: 8),
                    const Text(
                      "Your balance:",
                      style: TextStyle(color: AppColors.gray3, fontSize: 15),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${state.balance} points",
                      style: theme.textTheme.titleSmall,
                    )
                  ],
                ),
                const SizedBox(height: 12.0),
                const Divider(
                  color: AppColors.gray2,
                  thickness: 2,
                  height: 1,
                ),
                const SizedBox(height: 10.0),

                /// Timer and amount
                TimerAndAmountRow(cubit: cubit, state: state),
                const SizedBox(height: 12),

                /// Up and down buttons
                UpDownButtons(currency: currency, cubit: cubit, state: state)
              ],
            ),
          ),
        );
      },
    );
  }
}
