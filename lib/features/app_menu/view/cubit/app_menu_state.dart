import 'package:equatable/equatable.dart';

class AppMenuState extends Equatable {
  final int selectedItem;
  final bool timerFinished;
  final String dialogCurrency;
  final String dialogMoneyCount;
  final String dialogPoint;
  final bool dialogIsWon;

  const AppMenuState({
    this.selectedItem = 1,
    this.timerFinished = false,
    this.dialogCurrency = '',
    this.dialogMoneyCount = '',
    this.dialogPoint = '',
    this.dialogIsWon = false,
  });

  AppMenuState copyWith({
    int? selectedItem,
    bool? timerFinished,
    double? timer,
    String? dialogCurrency,
    String? dialogMoneyCount,
    String? dialogPoint,
    bool? dialogIsWon,
  }) {
    return AppMenuState(
      selectedItem: selectedItem ?? this.selectedItem,
      timerFinished: timerFinished ?? this.timerFinished,
      dialogCurrency: dialogCurrency ?? this.dialogCurrency,
      dialogMoneyCount: dialogMoneyCount ?? this.dialogMoneyCount,
      dialogPoint: dialogPoint ?? this.dialogPoint,
      dialogIsWon: dialogIsWon ?? this.dialogIsWon,
    );
  }

  @override
  List<Object?> get props => [
        selectedItem,
        timerFinished,
        dialogCurrency,
        dialogMoneyCount,
        dialogPoint,
        dialogIsWon,
      ];
}
