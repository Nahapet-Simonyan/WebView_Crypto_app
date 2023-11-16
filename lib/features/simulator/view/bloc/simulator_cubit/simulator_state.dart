part of 'simulator_cubit.dart';

abstract class SimulatorState extends Equatable {
  final String? currency;

  const SimulatorState({required this.currency});
}

class SimulatorInitialState extends SimulatorState {
  const SimulatorInitialState({super.currency});

  @override
  List<Object> get props => [];
}

class SimulatorCompletedState extends SimulatorState {
  final WebViewController? controller;
  final List<CurrencyItem>? currencyItemsList;

  const SimulatorCompletedState({
    this.controller,
    super.currency,
    this.currencyItemsList,
  });

  @override
  List<Object?> get props => [currency, currencyItemsList];
}
