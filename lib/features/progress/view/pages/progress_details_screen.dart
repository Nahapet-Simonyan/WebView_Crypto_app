import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bin7r4decl/features/history/view/ui_cubit/history_cubit.dart';
import 'package:bin7r4decl/features/history/view/ui_cubit/history_state.dart';
import '../widgets/deals_box.dart';
import '../../../../components/history_box.dart';
import '../../../../components/custom_app_bar.dart';

class ProgressDetails extends StatelessWidget {
  const ProgressDetails({super.key, required this.item, required this.asState});

  final Map<String, dynamic> item;
  final num asState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: const CustomAppBar(title: 'Achievement'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DealsBox(
                    item: item,
                    asState: asState,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'History',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16.0),
                  BlocBuilder<HistoryCubit, HistoryState>(
                    builder: (context, state) {
                      final betList = state.finishedBets;
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: betList?.length ?? 0,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16.0),
                        itemBuilder: (context, index) {
                          if (state.finishedBets != null &&
                              state.finishedBets!.isNotEmpty) {
                            return HistoryBox(
                              theme: theme,
                              bet: state.finishedBets![index],
                            );
                          }
                          return const SizedBox();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
