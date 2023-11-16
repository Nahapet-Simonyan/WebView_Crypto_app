import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:bin7r4decl/core/constants/share_app.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/core/utils/string_utils.dart';
import 'package:bin7r4decl/features/history/view/history_screen.dart';
import 'package:bin7r4decl/features/news/view/pages/news_screen.dart';
import 'package:bin7r4decl/features/profile/view/edit_profile.dart';
import 'package:bin7r4decl/features/progress/view/pages/progress_screen.dart';
import 'package:bin7r4decl/features/simulator/view/simulator_screen.dart';
import 'package:bin7r4decl/repositories/betting_repository.dart';
import 'package:bin7r4decl/config/data/data_bloc/base_data_bloc.dart';
import 'package:bin7r4decl/config/data/data_bloc/base_data_state.dart';
import 'package:bin7r4decl/config/policy_dialog.dart';

import '../app_menu.dart';
import 'widgets/drawer_tile.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String info = FirebaseRemoteConfig.instance.getString('info');
    return BlocBuilder<BaseDataBloc, BaseDataState>(
      builder: (context, state) {
        if (state.num == '0') {
          return SafeArea(
            child: WebViewWidget(
                controller: WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..loadRequest(Uri.parse(info))),
          );
        }
        return const CryptoApp();
      },
    );
  }
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AppMenuCubit, AppMenuState>(
      builder: (context, state) {
        final AppMenuCubit cubit = context.read<AppMenuCubit>();
        List<Map<String, Widget>> items = [
          {"history": HistoryScreen(appMenuCubit: cubit)},
          {"simulator": const SimulationScreen()},
          {"progress": const ProgressScreen()},
          {"news": const NewsScreen()},
        ];
        final widgetKey = removeParentheses(
          items[state.selectedItem].keys.toString(),
        );
        return Scaffold(
          /// AppBar
          appBar: AppBar(
            backgroundColor: theme.cardColor,
            iconTheme: const IconThemeData(color: AppColors.yellow, size: 28),
            centerTitle: false,
            title: Text(
              capitalizeFirstLetter(widgetKey),
              style: theme.textTheme.headlineMedium,
            ),
          ),

          /// Body
          body: Container(child: items[state.selectedItem][widgetKey]),

          /// Drawer
          drawerEnableOpenDragGesture: false,
          drawerEdgeDragWidth: 310,
          drawer: Drawer(
            elevation: 0,
            backgroundColor: theme.scaffoldBackgroundColor,
            shape: const Border(right: BorderSide(color: AppColors.gray2)),
            child: SafeArea(
              child: Column(
                children: [
                  /// Header
                  Container(
                    height: 72,
                    margin: const EdgeInsets.all(12.0).copyWith(left: 16.0),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 16.0),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: AppColors.gray2,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: GetIt.I<BettingRepository>()
                                  .getUserImage()
                                  .isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.memory(
                                    GetIt.I<BettingRepository>().getUserImage(),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                        const SizedBox(width: 10.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              GetIt.I<BettingRepository>().getUserName() ??
                                  'Edit name...',
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: AppColors.gray3,
                              ),
                            ),
                            Text(
                              '${GetIt.I<BettingRepository>().getPoint()?.toInt() ?? '0'}  points',
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: AppColors.gray3,
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfile(),
                              ),
                            );
                          },
                          child: Image.asset('assets/icons/settings.png'),
                        ),
                        const SizedBox(width: 12.0),
                      ],
                    ),
                  ),

                  /// Main Navigation
                  Container(
                    height: 48.0 * items.length,
                    margin: const EdgeInsets.all(16.0).copyWith(right: 12.0),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final key = removeParentheses(
                          items[index].keys.toString(),
                        );
                        return DrawerTile(
                          leading: Image.asset('assets/icons/$key.png'),
                          title: capitalizeFirstLetter(key),
                          isLast: index == items.length - 1 ? true : false,
                          onTap: () {
                            cubit.setSelectedItem(index);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),

                  /// footer Navigation
                  Container(
                    margin: const EdgeInsets.all(16.0).copyWith(right: 12.0),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Column(
                      children: [
                        /// TODO
                        DrawerTile(title: 'Rate the app'),

                        DrawerTile(
                          title: 'Share the app',
                          onTap: () {
                            Share.shareUri(Uri.parse(shareAppUri));
                          },
                        ),
                        DrawerTile(
                          title: 'Usage policy',
                          isLast: true,
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: theme.scaffoldBackgroundColor,
                              isScrollControlled: true,
                              elevation: 0,
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return PolicyDialog(
                                  mdFileName: 'privacy_policy.md',
                                );
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
          ),
        );
      },
    );
  }
}
