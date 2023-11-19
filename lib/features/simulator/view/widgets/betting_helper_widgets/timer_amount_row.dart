import 'package:flutter/material.dart';

import 'package:bin7r4decl/features/simulator/view/cubits/cubits.dart';
import 'package:bin7r4decl/features/simulator/view/widgets/widgets.dart';


class TimerAndAmountRow extends StatelessWidget {
  const TimerAndAmountRow(
      {super.key, required this.cubit, required this.state});

  final BettingCubit cubit;
  final BettingState state;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<String>> dropdownBetTime = const [
      DropdownMenuEntry(value: "0.3", label: "00:30"),
      DropdownMenuEntry(value: "1", label: "01:00"),
      DropdownMenuEntry(value: "5", label: "05:00"),
      DropdownMenuEntry(value: "10", label: "10:00"),
      DropdownMenuEntry(value: "30", label: "30:00"),
    ];

    List<DropdownMenuEntry<String>> dropdownBetCount = const [
      DropdownMenuEntry(value: "1", label: "\$ 1"),
      DropdownMenuEntry(value: "5", label: "\$ 5"),
      DropdownMenuEntry(value: "10", label: "\$ 10"),
      DropdownMenuEntry(value: "50", label: "\$ 50"),
      DropdownMenuEntry(value: "100", label: "\$ 100"),
      DropdownMenuEntry(value: "200", label: "\$ 200"),
      DropdownMenuEntry(value: "500", label: "\$ 500"),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Timer
        CustomDropdownMenu(
          initialSelection: '0.3',
          onSelected: (value) => cubit.updateTimerOrAmount(timer: value),
          leadingIcon: Image.asset("assets/icons/yellow_stop_watch.png"),
          dropdownMenuEntries: dropdownBetTime,
        ),
        //Amount
        CustomDropdownMenu(
          initialSelection: '50',
          onSelected: (value) => cubit.updateTimerOrAmount(
            amount: int.parse(value!),
          ),
          leadingIcon: Image.asset("assets/icons/yellow_dollar.png"),
          dropdownMenuEntries: dropdownBetCount,
        ),
      ],
    );
  }
}
