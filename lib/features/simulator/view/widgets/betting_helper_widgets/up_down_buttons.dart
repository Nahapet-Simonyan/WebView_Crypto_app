import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bin7r4decl/components/custom_button.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/core/enums/betting_status.dart';

import '../../bloc/betting_cubit/betting_cubit.dart';
import 'status_dialog.dart';

class UpDownButtons extends StatelessWidget {
  const UpDownButtons({
    super.key,
    required this.cubit,
    required this.currency,
    required this.state,
  });

  final BettingCubit cubit;
  final BettingState state;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 2.25,
          child: CustomButton(
            onTap: () async {
              makeDialAndShowDialog(context: context, type: 'up');
            },
            color: AppColors.green,
            suffixIcon: Image.asset('assets/icons/arrow_up.png'),
            child: Text(
              "UP",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 2.25,
          child: CustomButton(
            color: AppColors.red,
            onTap: () async {
              makeDialAndShowDialog(context: context, type: 'down');
            },
            suffixIcon: Image.asset(
              'assets/icons/arrow_down.png',
            ),
            child: Text(
              "DOWN",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        )
      ],
    );
  }

  makeDialAndShowDialog({required context, required type}) async {
    try {
      final result = await cubit.makeDeal(
        context: context,
        currencyPair: currency ?? "",
        type: type,
        timer: state.timer,
        amount: state.amount,
      );

      if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) => StatusDialog(status: result),
        );

      if (result == BettingStatus.zeroBalance) {
        await cubit.setBalance(1000);
        return;
      }
      if (result == BettingStatus.success) {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
