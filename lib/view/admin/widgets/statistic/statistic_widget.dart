import 'package:flutter/material.dart';
import 'package:pfe_salim/utils/language/localization.dart';

import '../../../../../model/statistic.dart';
import '../../../../../utils/dimensions.dart';

class StatisticWidget extends StatelessWidget {
  final Statistic statistic;
  final VoidCallback? tapAction;

  const StatisticWidget({
    super.key,
    required this.statistic,
    this.tapAction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapAction,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: Dimensions.roundedBorderBig,
        ),
        child: Padding(
          padding: Dimensions.mediumPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${intl.doubleDotPlaceholder(intl.id)} "
                "${statistic.id}",
              ),
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
}
