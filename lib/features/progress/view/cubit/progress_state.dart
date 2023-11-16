part of 'progress_cubit.dart';

class ProgressState extends Equatable {
  final int level;
  final int fullProgress;
  final int deal;
  final int successfulDeal;
  final double binding;
  final double point;

  const ProgressState({
    this.level = 1,
    this.fullProgress = 5000,
    this.deal = 0,
    this.successfulDeal = 0,
    this.binding = 0.0,
    this.point = 0.0,
  });

  ProgressState copyWith({
    int? level,
    int? fullProgress,
    int? deal,
    int? successfulDeal,
    double? binding,
    double? point,
  }) {
    return ProgressState(
      level: level ?? this.level,
      fullProgress: fullProgress ?? this.fullProgress,
      deal: deal ?? this.deal,
      successfulDeal: successfulDeal ?? this.successfulDeal,
      binding: binding ?? this.binding,
      point: point ?? this.point,
    );
  }

  @override
  List<Object?> get props => [
        level,
        fullProgress,
        deal,
        successfulDeal,
        binding,
        point,
      ];
}
