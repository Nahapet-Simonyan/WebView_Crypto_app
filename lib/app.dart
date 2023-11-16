import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/app_dialog.dart';
import 'config/data/data_bloc/base_data_bloc.dart';
import 'config/data/data_bloc/base_data_state.dart';
import 'features/app_menu/app_menu.dart';
import 'features/onboarding/view/view.dart';

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
              print(state.num);
              return const OnboardingVersion1();
            }
            return const OnboardingVersion2();
          },
        ),
      ),
    );
  }
}
