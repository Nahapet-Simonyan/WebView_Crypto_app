import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:bin7r4decl/features/history/history.dart';
import 'package:bin7r4decl/features/progress/progress.dart';
import 'package:bin7r4decl/features/simulator/simulator.dart';

import 'app_menu_state.dart';

class AppMenuCubit extends Cubit<AppMenuState> {
  AppMenuCubit() : super(const AppMenuState());

  setSelectedItem(int selectedItem) {
    emit(state.copyWith(selectedItem: selectedItem));
  }

  startTimer({
    required BettingCubit bettingCubit,
    required HistoryCubit historyCubit,
    required ProgressCubit progressCubit,
    required int seconds,
    required int minutes,
    required BetModel bet,
  }) {
    Future.delayed(Duration(seconds: seconds, minutes: minutes), () {
      writeData(
        bettingCubit: bettingCubit,
        historyCubit: historyCubit,
        progressCubit: progressCubit,
        seconds: seconds,
        minutes: minutes,
        bet: bet,
      );
    });
  }

  writeData({
    required BettingCubit bettingCubit,
    required HistoryCubit historyCubit,
    required ProgressCubit progressCubit,
    required int seconds,
    required int minutes,
    required BetModel bet,
  }) {
    var isWon = Random().nextBool();
    emit(
      state.copyWith(
        timerFinished: true,
        dialogCurrency: bet.currencyPair,
        dialogMoneyCount: bet.amount.toString(),
        dialogPoint: (bet.amount + bet.amount / 10).toString(),
        dialogIsWon: isWon,
      ),
    );
    GetIt.I<BettingRepository>().saveOrUpdateBet(
      BetModel(
        currencyPair: bet.currencyPair,
        amount: bet.amount,
        type: bet.type,
        startTime: bet.startTime,
        endTime: bet.endTime,
        isFinished: true,
        isWon: isWon,
      ),
    );

    int? dial = GetIt.I<BettingRepository>().getDials();
    dial == null
        ? GetIt.I<BettingRepository>().addDial(1)
        : GetIt.I<BettingRepository>().addDial(dial + 1);
    GetIt.I<BettingRepository>().addBinding(bet.amount.toDouble());
    progressCubit.initial();
    historyCubit.getBets();

    if (isWon) {
      bettingCubit.addBalance(bet.amount + bet.amount / 10);
      int? sDial = GetIt.I<BettingRepository>().getSuccessfulDials();
      sDial == null
          ? GetIt.I<BettingRepository>().addSuccessfulDial(1)
          : GetIt.I<BettingRepository>().addSuccessfulDial(sDial + 1);
    } else {
      bettingCubit.removeBalance(bet.amount + bet.amount / 10);
    }

    emit(state.copyWith(timerFinished: false));
  }
}
