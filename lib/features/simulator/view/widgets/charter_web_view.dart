import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/features/simulator/data/data.dart';
import 'package:bin7r4decl/features/simulator/view/cubits/cubits.dart';
import 'package:bin7r4decl/features/simulator/view/widgets/widgets.dart';


class CharterWebViewWidget extends StatelessWidget {
  final WebViewController controller;
  final String? currency;
  final List<CurrencyItem>? currencyItemsList;

  const CharterWebViewWidget({
    super.key,
    required this.controller,
    this.currency,
    this.currencyItemsList,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SimulatorCubit>();
    return Stack(
      children: [
        WebViewWidget(controller: controller),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: CustomDropdownMenu(
              width: 155,
              backgroundColor: Theme.of(context).cardColor,
              textStyle: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.gray3),
              initialSelection: currencyItemsList
                  ?.firstWhere(
                    (element) => element.currencyPair == currency,
                    orElse: () => currencyItemsList!.first,
                  )
                  .currencyPair,
              onSelected: (val) {
                try {
                  if (val is String) cubit.fetchNewChart(val);
                } catch (e) {}
              },
              dropdownMenuEntries: [
                ...?currencyItemsList?.map(
                  (e) {
                    return DropdownMenuEntry(
                      value: e.currencyPair ?? '',
                      label: e.currencyPair != null
                          ? "${e.currencyPair?.substring(0, 3)}/${e.currencyPair?.substring(3)}"
                          : "",
                      style: const ButtonStyle(
                        textStyle: MaterialStatePropertyAll(
                          TextStyle(color: AppColors.gray2, fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
