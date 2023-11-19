
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:bin7r4decl/features/simulator/data/data.dart';
import 'package:bin7r4decl/features/simulator/view/cubits/cubits.dart';
import 'package:bin7r4decl/features/simulator/view/widgets/widgets.dart';

class SimulationScreen extends StatelessWidget {
  const SimulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimulatorCubit, SimulatorState>(
      builder: (context, state) {
        if (state is SimulatorCompletedState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CharterWebViewWidget(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(const Color(0x00000000))
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onProgress: (int progress) {
                          // Update loading bar.
                        },
                        onPageStarted: (String url) {},
                        onPageFinished: (String url) {},
                        onWebResourceError: (WebResourceError error) {},
                        onNavigationRequest: (NavigationRequest request) {
                          if (request.url
                              .startsWith('https://www.youtube.com/')) {
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        },
                      ),
                    )
                    ..loadRequest(
                      Uri.dataFromString(
                        HtmlData.getHtmlData(),
                        mimeType: 'text/html',
                        // encoding: Encoding.getByName('utf-8'),
                      ),
                    ),
                  currency: state.currency,
                  currencyItemsList: state.currencyItemsList,
                ),
              ),
              BettingWidget(currency: state.currency),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
