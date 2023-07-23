import 'package:flutter/material.dart';

import '../../utils/theme/theme_styles.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;
  final Function? tapFunction;

  const CustomErrorWidget({
    super.key,
    this.error = "Network error",
    this.tapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: dangerColor, size: 40),
          Text(error),
          if (tapFunction != null) const SizedBox(height: 20),
          if (tapFunction != null)
            TextButton(
              onPressed: () => tapFunction!(),
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  Colors.transparent,
                ),
                foregroundColor: MaterialStatePropertyAll(
                  Styles.primaryColor,
                ),
              ),
              child: const Text("Tap here to refresh"),
            )
        ],
      ),
    );
  }
}
