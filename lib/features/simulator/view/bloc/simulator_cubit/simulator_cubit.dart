import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bin7r4decl/core/constants/request_helper.dart';
import 'package:bin7r4decl/features/simulator/data/models/currency_item.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../document_source/document_source.dart';

part 'simulator_state.dart';

class SimulatorCubit extends Cubit<SimulatorState> {
  SimulatorCubit({this.currency, this.dioClient})
      : super(SimulatorInitialState(currency: currency)) {
    initController();
  }

  String? currency;
  Dio? dioClient;

  initController() async {
    await setUpController();
    await fetchCurrencyPairs();
  }

  setUpController() async {
    try {
      WebViewController controller;
      if (state is SimulatorInitialState) {
        controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                return NavigationDecision.prevent;
              },
            ),
          );

        await controller.loadRequest(
          Uri.dataFromString(
            DocumentSource.getHtmlData(),
            mimeType: 'text/html',
            // encoding: Encoding.getByName('utf-8'),
          ),
        );
      } else {
        controller = WebViewController();
      }
      emit(
        SimulatorCompletedState(
          currency: (state as SimulatorInitialState).currency,
          controller: controller,
        ),
      );
    } catch (e) {
      WebViewController controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.prevent;
            },
          ),
        );

      // await controller.loadRequest(
      //   Uri.dataFromString(
      //     DocumentSource.getHtmlData(),
      //     mimeType: 'text/html',
      //     encoding: Encoding.getByName('utf-8'),
      //   ),
      // );

      emit(
        SimulatorCompletedState(
          currency: (state as SimulatorInitialState).currency,
          controller: controller,
        ),
      );
    }
  }

  fetchCurrencyPairs() async {
    try {
      final result = await dioClient?.get(
        "${AppUrls.beretukBaseUrl}/fetch/currencies",
        queryParameters: {"token": AppTokens.beretukToken},
      );

      if (result?.data == null) {
        return;
      }
      if (result?.data["results"] == null) {
        return;
      }

      List<CurrencyItem> items = List.empty(growable: true);

      for (var element in (result?.data["results"] as List)) {
        items.add(CurrencyItem.fromJson(element));
      }

      if (state is SimulatorCompletedState) {
        emit(
          SimulatorCompletedState(
            controller: (state as SimulatorCompletedState).controller,
            currency: (state as SimulatorCompletedState).currency,
            currencyItemsList: items,
          ),
        );
      } else {
        emit(
          SimulatorCompletedState(
            currencyItemsList: items,
          ),
        );
      }
    } catch (e) {}
  }

  fetchNewChart(String currencyPair) async {
    if (state is SimulatorCompletedState) {
      await (state as SimulatorCompletedState).controller?.loadRequest(
            Uri.dataFromString(
              DocumentSource.getHtmlData(currency: currencyPair),
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ),
          );

      emit(
        SimulatorCompletedState(
          currency: currencyPair,
          controller: (state as SimulatorCompletedState).controller,
          currencyItemsList:
              (state as SimulatorCompletedState).currencyItemsList,
        ),
      );
    }
  }
}
