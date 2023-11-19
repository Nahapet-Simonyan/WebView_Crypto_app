import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bin7r4decl/components/components.dart';
import 'package:bin7r4decl/core/base_data/base_data.dart';
import 'package:bin7r4decl/features/app_menu/app_menu.dart';
import 'package:bin7r4decl/features/onboarding/onboarding.dart';

import 'features/app_menu/view/cubit/app_menu_state.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppMenuCubit, AppMenuState>(
      listener: (context, state) {
        if (state.timerFinished == true) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: AppDialog(state: state),
              );
            },
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<BaseDataBloc, BaseDataState>(
          builder: (context, state) {
            if(state is BaseDataDone && state.num == '1'){
              if (kDebugMode) {
                print(state.num);
              }
              return const OnboardingVersion1();
            }
            if (kDebugMode) {
              print(state.error);
            }
            return const OnboardingVersion2();
          },
        ),
      ),
    );
  }
}
