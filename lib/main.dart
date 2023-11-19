import 'dart:math';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:bin7r4decl/firebase_options.dart';
import 'package:bin7r4decl/core/base_data/base_data.dart';
import 'package:bin7r4decl/core/splash/splash.dart';
import 'package:bin7r4decl/config/injection_container.dart';
import 'package:bin7r4decl/config/themes/dark_theme.dart';
import 'package:bin7r4decl/features/app_menu/app_menu.dart';
import 'package:bin7r4decl/features/history/history.dart';
import 'package:bin7r4decl/features/news/news.dart';
import 'package:bin7r4decl/features/progress/progress.dart';
import 'package:bin7r4decl/features/simulator/simulator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NewsRepository(GetIt.I<NewsApi>()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppMenuCubit()),
          BlocProvider(
            create: (context) => BaseDataBloc(
              GetIt.I<BaseRepository>(),
            )..add(const GetData()),
          ),
          BlocProvider(
            create: (context) => SimulatorCubit(
              currency: "EURUSD",
              dioClient: GetIt.I<Dio>(),
            ),
          ),
          BlocProvider(create: (context) => HistoryCubit()),
          BlocProvider(
            create: (context) => NewsBloc(
              RepositoryProvider.of<NewsRepository>(context),
            )..add(const GetNews()),
          ),
          BlocProvider(
            create: (context) => BettingCubit(
              downRatePercentage: Random().nextInt(100).toDouble(),
            ),
          ),
          BlocProvider(create: (context) => ProgressCubit()),
        ],
        child: MaterialApp(
          theme: darkTheme,
          home: const Scaffold(body: SplashScreen()),
        ),
      ),
    );
  }
}
