import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:bin7r4decl/features/simulator/data/data.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(const ProgressState()) {
    initial();
  }

  List<BetModel> bets = GetIt.I<BettingRepository>().getSavedBets();

  initial() {
    int? dials = GetIt.I<BettingRepository>().getDials();
    int? successfulDials = GetIt.I<BettingRepository>().getSuccessfulDials();
    double? bindings = GetIt.I<BettingRepository>().getBindings();
    double? point = GetIt.I<BettingRepository>().getPoint();

    if (state.point % 5000 == 0) {
      emit(state.copyWith(
        level: state.level + 1,
        fullProgress: state.fullProgress + 5000,
      ));
    }

    emit(
      state.copyWith(
        deal: dials,
        successfulDeal: successfulDials,
        binding: bindings,
        point: point,
      ),
    );
  }

  levelUp() {}
}
