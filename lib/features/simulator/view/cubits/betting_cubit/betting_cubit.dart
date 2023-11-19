
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bin7r4decl/core/enums/betting_status.dart';
import 'package:bin7r4decl/features/simulator/data/data.dart';
import 'package:bin7r4decl/features/app_menu/app_menu.dart';
import 'package:bin7r4decl/features/history/history.dart';
import 'package:bin7r4decl/features/progress/progress.dart';

part 'betting_state.dart';

class BettingCubit extends Cubit<BettingState> {
  late final SharedPreferences preferences;

  BettingCubit({double downRatePercentage = 60})
      : super(BettingState(downRatePercentage: downRatePercentage)) {
    _loadMissing();
  }

  _loadMissing() async {
    await _loadSharedPrefs();
    await loadBalance();
  }

  _loadSharedPrefs() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<BettingStatus> makeDeal({
    required BuildContext context,
    required String currencyPair,
    required String timer,
    required String type,
    required int amount,
  }) async {
    final appMenuCubit = context.read<AppMenuCubit>();
    final bettingCubit = context.read<BettingCubit>();
    final historyCubit = context.read<HistoryCubit>();
    final progressCubit = context.read<ProgressCubit>();
    try {
      if (state.balance == 0) return BettingStatus.zeroBalance;
      if (amount > state.balance) return BettingStatus.notEnough;

      await setBalance(state.balance - amount);

      final bet = BetModel(
        currencyPair:
            "${currencyPair.substring(0, 3)}/${currencyPair.substring(3)}",
        amount: amount,
        type: type,
        startTime: DateTime.now(),
        endTime: addMinutesToCurrentDate(
          currentDate: DateTime.now(),
          selectedSeconds: state.timerSeconds,
          selectMinutes: state.timerMinutes,
        ),
        isFinished: false,
      );

      //Save date
      GetIt.I<BettingRepository>().saveOrUpdateBet(bet);

      //Start timer
      appMenuCubit.startTimer(
        bettingCubit: bettingCubit,
        historyCubit: historyCubit,
        progressCubit: progressCubit,
        seconds: state.timerSeconds,
        minutes: state.timerMinutes,
        bet: bet,
      );

      historyCubit.getBets();
      progressCubit.initial();
      return BettingStatus.success;
    } catch (e) {
      return BettingStatus.error;
    }
  }

  setBalance(double newBalance) async {
    await GetIt.I<BettingRepository>().addPoint(newBalance);
    try {
      await preferences.setDouble("balance", newBalance);
      emit(state.copyWith(balance: newBalance));
    } catch (e) {}
  }

  addBalance(double balance) async {
    double newBalance = state.balance + balance;
    setBalance(newBalance);
  }

  removeBalance(double balance) async {
    double newBalance = state.balance - balance;
    setBalance(newBalance);
  }

  loadBalance() async {
    try {
      double? balance = preferences.getDouble("balance");
      if (balance == null) {
        preferences.setDouble("balance", 1000.0);
      }

      emit(state.copyWith(balance: balance ?? 1000.0));
    } catch (e) {}
  }

  updateTimerOrAmount({String? timer, int? amount}) {
    if (timer != null) {
      emit(state.copyWith(timer: timer));

      if (double.parse(timer) < 1) {
        double doubleValue = double.parse(timer);
        int intValue = (doubleValue * 100).toInt();

        emit(state.copyWith(timerSeconds: intValue, timerMinutes: 0));
      } else {
        emit(
          state.copyWith(timerSeconds: 0, timerMinutes: int.parse(timer)),
        );
      }
    }

    if (amount != null) {
      emit(state.copyWith(amount: amount));
    }
  }

  DateTime addMinutesToCurrentDate({
    required DateTime currentDate,
    required int selectedSeconds,
    int? selectMinutes,
  }) {
    DateTime finishedAt;
    if (selectMinutes == null) {
      finishedAt = currentDate.add(Duration(seconds: selectedSeconds));
    } else {
      finishedAt = currentDate.add(
        Duration(
          seconds: selectedSeconds,
          minutes: selectMinutes,
        ),
      );
    }
    return finishedAt;
  }
}
