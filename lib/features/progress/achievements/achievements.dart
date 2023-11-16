import 'package:bin7r4decl/core/enums/achievement_type.dart';

List<Map<String, dynamic>> achievements = [
  //Deal
  {
    'name': '20 deals',
    'type': AchievementType.deal,
    'max': 20,
    'reward': 500.0,
  },
  {
    'name': '40 deals',
    'type': AchievementType.deal,
    'max': 40,
    'reward': 1000.0,
  },
  {
    'name': '100 deals',
    'type': AchievementType.deal,
    'max': 100,
    'reward': 2000.0,
  },

  //Successful deal
  {
    'name': '10 successful deals',
    'type': AchievementType.successfulDeal,
    'max': 10,
    'reward': 1000.0,
  },
  {
    'name': '20 successful deals',
    'type': AchievementType.successfulDeal,
    'max': 20,
    'reward': 5000.0,
  },
  {
    'name': '80 successful deals',
    'type': AchievementType.successfulDeal,
    'max': 80,
    'reward': 10000.0,
  },

  //Binding
  {
    'name': 'Binding for \$100',
    'type': AchievementType.binding,
    'max': 100.0,
    'reward': 500.0,
  },
  {
    'name': 'Binding for \$200',
    'type': AchievementType.binding,
    'max': 200.0,
    'reward': 1000.0,
  },
  {
    'name': 'Binding for \$500',
    'type': AchievementType.binding,
    'max': 500.0,
    'reward': 5000.0,
  },
  {
    'name': 'Binding for \$1000',
    'type': AchievementType.binding,
    'max': 1000.0,
    'reward': 10000.0,
  },
];
