import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:bin7r4decl/config/data/data.dart';
import 'package:bin7r4decl/config/data/data_bloc/base_data_bloc.dart';
import 'package:bin7r4decl/config/data/data_bloc/base_data_event.dart';
import 'package:bin7r4decl/firebase_options.dart';
import 'package:bin7r4decl/config/injection_container.dart';
import 'package:bin7r4decl/config/themes/dark_theme.dart';
import 'package:bin7r4decl/config/splash/splash.dart';
import 'package:bin7r4decl/features/app_menu/app_menu.dart';
import 'package:bin7r4decl/features/history/view/ui_cubit/history_cubit.dart';
import 'package:bin7r4decl/features/news/news.dart';
import 'package:bin7r4decl/features/progress/view/cubit/progress_cubit.dart';
import 'package:bin7r4decl/features/simulator/view/bloc/betting_cubit/betting_cubit.dart';
import 'package:bin7r4decl/features/simulator/view/bloc/simulator_cubit/simulator_cubit.dart';

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
    final Dio dio = Dio();

    return RepositoryProvider(
      create: (context) => NewsRepository(GetIt.I<NewsApi>()),
      child: MultiBlocProvider(
        providers: [
          /// config
          BlocProvider(
            create: (context) =>
                BaseDataBloc(GetIt.I<BaseRepository>())..add(const GetData()),
          ),

          /// app
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
          BlocProvider(
            create: (context) => SimulatorCubit(
              currency: "EURUSD",
              dioClient: dio,
            ),
          ),
          BlocProvider(create: (context) => AppMenuCubit()),
          BlocProvider(create: (context) => HistoryCubit()),
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
