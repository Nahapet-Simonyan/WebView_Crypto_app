import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:bin7r4decl/repositories/models/bet_model/bet_model.dart';

class BettingRepository {
  BettingRepository({
    required this.betsBox,
    required this.dialsBox,
    required this.successfulDialsBox,
    required this.bindingsBox,
    required this.pointBox,
    required this.profileBox,
  });

  final Box<BetModel> betsBox;
  final Box<int> dialsBox;
  final Box<int> successfulDialsBox;
  final Box<double> bindingsBox;
  final Box<double> pointBox;
  final Box<dynamic> profileBox;

  /// Profile
  Future<void> saveOrUpdateName(String name) async {
    return profileBox.put('name', name);
  }

  String? getUserName() {
    return profileBox.get('name');
  }

  Future<void> saveOrUpdateImage(Uint8List image) async {
    return profileBox.put('image', image);
  }

  Uint8List getUserImage() {
    return profileBox.get('image');
  }

  /// Point
  Future<void> addPoint(double point) async {
    return pointBox.put('point', point);
  }

  double? getPoint() {
    return pointBox.get('point');
  }

  /// Bets
  List<BetModel> getSavedBets() {
    return betsBox.values.toList();
  }

  Future<void> saveOrUpdateBet(BetModel bet) async {
    return await betsBox.put(bet.startTime.toString(), bet);
  }

  Future<void> removeBet(BetModel bet) async {
    return await betsBox.delete(bet.startTime.toString());
  }

  /// Progress
  Future<void> addDial(int dial) async {
    return dialsBox.put('dials', dial);
  }

  int? getDials() {
    return dialsBox.get('dials');
  }

  Future<void> addSuccessfulDial(int successfulDial) async {
    return successfulDialsBox.put('successfulDials', successfulDial);
  }

  int? getSuccessfulDials() {
    return successfulDialsBox.get('successfulDials');
  }

  Future<void> addBinding(double binding) async {
    return bindingsBox.put('bindings', binding);
  }

  double? getBindings() {
    return bindingsBox.get('bindings');
  }
}
