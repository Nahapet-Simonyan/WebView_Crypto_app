import 'dart:typed_data';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:bin7r4decl/core/base_data/base_data.dart';
import 'package:bin7r4decl/features/app_menu/app_menu.dart';
import 'package:bin7r4decl/features/news/news.dart';
import 'package:bin7r4decl/features/simulator/simulator.dart';


Future<void> initializeDependencies() async {
  ///Firebase
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(seconds: 1),
  ));
  try {
    await remoteConfig.fetchAndActivate();
  } on Exception catch (e) {}

  ///Hive
  const betsBoxName = 'betsList';
  const dialsBoxName = 'dials';
  const successfulDialsName = 'successfulDials';
  const bindingsName = 'bindings';
  const pointName = 'point';
  const profileBoxName = 'user';

  await Hive.initFlutter();

  Hive.registerAdapter(BetModelAdapter());

  final betsBox = await Hive.openBox<BetModel>(betsBoxName);
  final dialsBox = await Hive.openBox<int>(dialsBoxName);
  final successfulDialsBox = await Hive.openBox<int>(successfulDialsName);
  final bindingsBox = await Hive.openBox<double>(bindingsName);
  final profileBox = await Hive.openBox<dynamic>(profileBoxName);

  double? binding = bindingsBox.get(bindingsName);
  if (binding == null) bindingsBox.put(bindingsName, 0.0);
  final pointBox = await Hive.openBox<double>(bindingsName);
  double? point = pointBox.get(pointName);
  if (point == null) pointBox.put(pointName, 0.0);
  Uint8List? image = profileBox.get('image');
  if (image == null) profileBox.put('image', Uint8List(0));

  ///GetIt
  GetIt.I.registerSingleton<Dio>(Dio());

  GetIt.I.registerSingleton<BaseApi>(BaseApi(GetIt.I<Dio>()));
  GetIt.I.registerSingleton<NewsApi>(NewsApi(GetIt.I<Dio>()));

  GetIt.I.registerSingleton<BaseRepository>(
    BaseRepository(GetIt.I<BaseApi>()),
  );

  GetIt.I.registerLazySingleton<BettingRepository>(
    () => BettingRepository(
      betsBox: betsBox,
      dialsBox: dialsBox,
      successfulDialsBox: successfulDialsBox,
      bindingsBox: bindingsBox,
      pointBox: pointBox,
      profileBox: profileBox,
    ),
  );

  GetIt.I.registerFactory<BettingCubit>(() => BettingCubit());
  GetIt.I.registerFactory<AppMenuCubit>(() => AppMenuCubit());
}

// String info = FirebaseRemoteConfig.instance.getString('info');
// bool isDead = FirebaseRemoteConfig.instance.getBool('isDead');
// bool needManagerScreen =
//     FirebaseRemoteConfig.instance.getBool('needManagerScreen');
// bool needTg = FirebaseRemoteConfig.instance.getBool('needTg');
// String tg = FirebaseRemoteConfig.instance.getString('tg');

// print('info: $info');
// print('isDead: $isDead');
// print('needManagerScreen: $needManagerScreen');
// print('needTg: $needTg');
// print('tg: $tg');

// betsBox.clear();
// dialsBox.clear();
// successfulDialsBox.clear();
// bindingsBox.clear();
// pointBox.clear();
