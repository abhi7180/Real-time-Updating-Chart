import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:real_time_updating_chart/module/chart_screen/controller/price_chart_controller.dart';
import 'package:real_time_updating_chart/module/chart_screen/model/chart_data_model.dart';
import 'package:real_time_updating_chart/utils/app_colors.dart';
import 'package:real_time_updating_chart/utils/app_string.dart';
import 'package:real_time_updating_chart/utils/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceChartScreen extends StatelessWidget {
  PriceChartScreen({super.key});

  final PriceChartController _priceChartController = Get.put(PriceChartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          AppString.appBarTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        forceMaterialTransparency: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        AppString.chart,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.primaryColor.withOpacity(.2),
                      height: 1,
                      thickness: 1,
                    ),
                    Expanded(
                      child: SfCartesianChart(
                        zoomPanBehavior: ZoomPanBehavior(
                          enablePanning: true,
                          enablePinching: true,
                          zoomMode: ZoomMode.x,
                        ),
                        primaryXAxis: NumericAxis(
                          decimalPlaces: 0,
                          axisLine: AxisLine(width: 1, color: AppColors.primaryColor.withOpacity(.2)),
                          majorGridLines: MajorGridLines(color: AppColors.primaryColor.withOpacity(.2)),
                          majorTickLines: const MajorTickLines(width: 0),
                          labelStyle: const TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                          title: const AxisTitle(text: AppString.dayNo),
                          labelFormat: '{value}',
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                        ),
                        primaryYAxis: NumericAxis(
                          axisLine: AxisLine(width: 1, color: AppColors.primaryColor.withOpacity(.2)),
                          majorGridLines: MajorGridLines(color: AppColors.primaryColor.withOpacity(.2)),
                          majorTickLines: const MajorTickLines(width: 0),
                          labelStyle: const TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          labelFormat: '{value} \$',
                          title: const AxisTitle(text: AppString.price),
                        ),
                        trackballBehavior: TrackballBehavior(
                          enable: true,
                          activationMode: ActivationMode.singleTap,
                          lineColor: AppColors.greyColor,
                          tooltipSettings:
                              const InteractiveTooltip(format: 'Price. point.y\nDay No. point.x', canShowMarker: false),
                        ),
                        tooltipBehavior: TooltipBehavior(
                          enable: false,
                        ),
                        series: <CartesianSeries>[
                          LineSeries<PriceDataModel, int>(
                            dataSource: _priceChartController.chartData,
                            xValueMapper: (PriceDataModel sales, _) => sales.time,
                            yValueMapper: (PriceDataModel sales, _) => sales.price,
                            width: 3,
                            color: AppColors.primaryColor.withOpacity(0.6),
                            enableTooltip: true,
                            animationDuration: 600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  AppString.refreshTime,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton<String>(
                    underline: const SizedBox.shrink(),
                    value: _priceChartController.selectedTimeFrame.value,
                    items: <String>[
                      Constants.tenSecond,
                      Constants.thirtySecond,
                      Constants.oneMinute,
                      Constants.fiveMinute,
                      Constants.thirtyMinute,
                      Constants.oneHour,
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: _priceChartController.onTimeFrameChanged,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        AppString.refreshHistory,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.primaryColor.withOpacity(.2),
                      height: 1,
                      thickness: 1,
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        reverse: true,
                        controller: _priceChartController.historyScrollController,
                        itemCount: _priceChartController.chartData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat("hh:mm:ss a").format(_priceChartController.chartData[index].dateTime),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DateFormat("dd/MM/yy").format(_priceChartController.chartData[index].dateTime),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              "${_priceChartController.chartData[index].price}\$",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${AppString.dayNo} ${_priceChartController.chartData[index].time}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: AppColors.primaryColor.withOpacity(.2),
                            height: 1,
                            thickness: 1,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
