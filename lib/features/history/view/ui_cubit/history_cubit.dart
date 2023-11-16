import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:bin7r4decl/core/enums/history_type.dart';
import 'package:bin7r4decl/repositories/betting_repository.dart';
import 'package:bin7r4decl/repositories/models/bet_model/bet_model.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(const HistoryState()) {
    getBets();
  }

  changeHistoryType(HistoryType type) {
    emit(state.copyWith(type: type));
  }

  getBets() {
    List<BetModel> currentBets = [];
    List<BetModel> finishedBets = [];

    List<BetModel> bets = GetIt.I<BettingRepository>().getSavedBets();

    for (var e in bets) {
      if (e.isFinished == true) {
        finishedBets.add(e);
      } else {
        currentBets.add(e);
      }
    }

    emit(
      state.copyWith(
        currentBets: currentBets,
        finishedBets: finishedBets,
      ),
    );
  }

  clearCurrentList() {
    emit(state.copyWith(currentBets: []));
  }
}
