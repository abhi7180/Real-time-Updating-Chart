import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:real_time_updating_chart/module/chart_screen/model/chart_data_model.dart';
import 'package:real_time_updating_chart/utils/constants.dart';

class PriceChartController extends GetxController {
  final List<int> _priceList = List.generate(1000, (index) => index + 1);

  RxInt interval = 0.obs;

  RxList<PriceDataModel> chartData = <PriceDataModel>[].obs;

  ScrollController historyScrollController = ScrollController();

  int getNewPrice() {
    _priceList.shuffle();
    return _priceList.first;
  }

  Timer? timer;
  RxString selectedTimeFrame = Constants.tenSecond.obs;
  RxInt timeFrameSeconds = 10.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setInitialValue();
    setNewValues();
  }

  void setInitialValue() {
    for (int i = 0; i < 10; i++) {
      interval++;
      chartData.add(
        PriceDataModel(
          time: interval.value,
          price: getNewPrice(),
          dateTime: DateTime.now(),
        ),
      );
    }
    scrollToTop();
  }

  void scrollToTop() {
    Future.delayed(
      const Duration(milliseconds: 400),
      () => historyScrollController.animateTo(
        historyScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 600),
        curve: Curves.decelerate,
      ),
    );
  }

  void setNewValues() {
    timer?.cancel();
    timer = Timer.periodic(
      Duration(seconds: timeFrameSeconds.value),
      (timer) {
        interval++;
        chartData.add(
          PriceDataModel(
            time: interval.value,
            price: getNewPrice(),
            dateTime: DateTime.now(),
          ),
        );
        scrollToTop();
      },
    );
  }

  void onTimeFrameChanged(String? newValue) {
    if (newValue != null) {
      selectedTimeFrame.value = newValue;
      switch (newValue) {
        case Constants.tenSecond:
          timeFrameSeconds.value = 10;
          break;
        case Constants.thirtySecond:
          timeFrameSeconds.value = 30;
          break;
        case Constants.oneMinute:
          timeFrameSeconds.value = 60;
          break;
        case Constants.fiveMinute:
          timeFrameSeconds.value = 300;
          break;
        case Constants.thirtyMinute:
          timeFrameSeconds.value = 1800;
          break;
        case Constants.oneHour:
          timeFrameSeconds.value = 3600;
          break;
      }
      setNewValues();
    }
  }
}
