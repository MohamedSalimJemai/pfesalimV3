import 'package:flutter/material.dart';
import 'package:pfe_salim/utils/theme/theme_styles.dart';
import 'package:pfe_salim/view/widgets/api_image_widget.dart';

import '../../../../../model/user.dart';
import '../../../../../utils/dimensions.dart';

class UserWidget extends StatelessWidget {
  final User user;
  final VoidCallback? tapAction;

  const UserWidget({
    super.key,
    required this.user,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ApiImageWidget(
                height: 60,
                width: 60,
                imageFilename: user.imageFilename,
                isCircular: true,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Email : ${user.email}",
                    ),
                    Text(
                      "Firstname : ${user.firstname}",
                    ),
                    Text(
                      "Lastname : ${user.lastname}",
                    ),
                  ],
                ),
              ),
              FilledButton.tonalIcon(
                onPressed: tapAction,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Styles.primaryColor.withOpacity(0.2),
                  ),
                  foregroundColor: MaterialStatePropertyAll(
                    Styles.primaryColor,
                  ),
                ),
                icon: const Icon(Icons.remove_red_eye),
                label: const Text("Show"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
