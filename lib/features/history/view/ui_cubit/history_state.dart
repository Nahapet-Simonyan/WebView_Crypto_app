import 'package:equatable/equatable.dart';

import 'package:bin7r4decl/core/enums/history_type.dart';
import 'package:bin7r4decl/features/simulator/simulator.dart';


class HistoryState extends Equatable {
  final HistoryType type;
  final List<BetModel>? currentBets;
  final List<BetModel>? finishedBets;

  const HistoryState({
    this.type = HistoryType.current,
    this.currentBets,
    this.finishedBets,
  });

  HistoryState copyWith({
    HistoryType? type,
    List<BetModel>? currentBets,
    List<BetModel>? finishedBets,
  }) {
    return HistoryState(
      type: type ?? this.type,
      currentBets: currentBets ?? this.currentBets,
      finishedBets: finishedBets ?? this.finishedBets,
    );
  }

  @override
  List<Object?> get props => [
        type,
        currentBets,
        finishedBets,
      ];
}
