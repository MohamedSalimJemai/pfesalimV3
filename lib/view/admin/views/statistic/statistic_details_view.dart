import 'package:flutter/material.dart';
import 'package:pfe_salim/api/view_model/statistic_view_model.dart';
import 'package:pfe_salim/utils/language/localization.dart';
import 'package:pfe_salim/utils/theme/theme_styles.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../../model/statistic.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../api/response/status.dart';
import '../../../widgets/custom_error_widget.dart';
import '../../../widgets/loading_widget.dart';

class StatisticDetailsView extends StatelessWidget {
  final Statistic statistic;

  const StatisticDetailsView({
    super.key,
    required this.statistic,
  });

  @override
  Widget build(BuildContext context) {
    // API
    StatisticViewModel statisticViewModel = StatisticViewModel();
    statisticViewModel.setItem(item: statistic, notifyChanges: false);

    return Scaffold(
      appBar: AppBar(title: Text("${intl.statistic} ${intl.details}")),
      body: Container(
        width: double.maxFinite,
        padding: Dimensions.mediumPadding,
        child: ChangeNotifierProvider<StatisticViewModel>(
          create: (context) => statisticViewModel,
          child: Consumer<StatisticViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.apiResponse.status == Status.completed) {
                return _buildStatisticDetailsWidget(
                  context: context,
                  statisticViewModel: viewModel,
                  statistic: viewModel.item,
                );
              } else if (viewModel.apiResponse.status == Status.loading) {
                return const LoadingWidget();
              } else {
                return const CustomErrorWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticDetailsWidget({
    required BuildContext context,
    required StatisticViewModel statisticViewModel,
    required Statistic statistic,
  }) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: Dimensions.roundedBorderBig,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildProgressCircle(progress: statistic.value.toDouble()),
              const SizedBox(height: 30),
              Text(
                "${intl.doubleDotPlaceholder(intl.value)} "
                "${statistic.value}",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCircle({required double progress}) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          axisLineStyle: const AxisLineStyle(
            thickness: 80,
            gradient: SweepGradient(
              colors: [
                dangerColor,
                warningColor,
                successColor,
                noticeColor,
              ],
            ),
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: progress,
              width: 65,
              sizeUnit: GaugeSizeUnit.logicalPixel,
              gradient: progress < 25
                  ? const SweepGradient(colors: [dangerColor])
                  : progress < 50
                      ? const SweepGradient(colors: [dangerColor, warningColor])
                      : progress < 75
                          ? const SweepGradient(
                              colors: [dangerColor, warningColor, successColor],
                            )
                          : const SweepGradient(
                              colors: [
                                dangerColor,
                                warningColor,
                                successColor,
                                noticeColor,
                              ],
                            ),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              axisValue: 5,
              positionFactor: 0.1,
              widget: Text(
                "${progress.toInt()} %",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
