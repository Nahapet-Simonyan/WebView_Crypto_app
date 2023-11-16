import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/simulator_cubit/simulator_cubit.dart';
import 'widgets/betting_widget.dart';
import 'widgets/charter_web_view.dart';

class SimulationScreen extends StatelessWidget {
  const SimulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimulatorCubit, SimulatorState>(
      builder: (context, state) {
        if (state is SimulatorCompletedState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CharterWebViewWidget(
                  controller: state.controller!,
                  currency: state.currency,
                  currencyItemsList: state.currencyItemsList,
                ),
              ),
              BettingWidget(currency: state.currency),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
