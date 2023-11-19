part of 'betting_cubit.dart';

class BettingState extends Equatable {
  final double downRatePercentage;
  final double balance;
  final String timer;
  final int timerSeconds;
  final int timerMinutes;
  final int amount;

  const BettingState({
    this.balance = 0,
    this.downRatePercentage = 60,
    this.timer = '0.3',
    this.timerSeconds = 30,
    this.timerMinutes = 0,
    this.amount = 50,
  });

  BettingState copyWith({
    double? downRatePercentage,
    double? balance,
    String? timer,
    int? timerSeconds,
    int? timerMinutes,
    int? amount,
  }) {
    return BettingState(
      balance: balance ?? this.balance,
      downRatePercentage: downRatePercentage ?? this.downRatePercentage,
      timer: timer ?? this.timer,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      timerMinutes: timerMinutes ?? this.timerMinutes,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [
        balance,
        downRatePercentage,
        timer,
        timerSeconds,
        timerMinutes,
        amount,
      ];
}
