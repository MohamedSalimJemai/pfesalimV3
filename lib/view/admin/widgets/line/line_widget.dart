import 'package:flutter/material.dart';
import 'package:pfe_salim/utils/language/localization.dart';

import '../../../../../model/line.dart';
import '../../../../../utils/dimensions.dart';

class LineWidget extends StatelessWidget {
  final Line line;
  final VoidCallback? tapAction;

  const LineWidget({
    super.key,
    required this.line,
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
                "${line.id}",
              ),
              Text(
                "${intl.doubleDotPlaceholder(intl.quantity)} "
                "${line.quantity}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
