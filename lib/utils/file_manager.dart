import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfe_salim/utils/theme/theme_styles.dart';

import 'alert_utils.dart';
import 'dimensions.dart';
import 'language/localization.dart';

class FileManager {
  static Future<String?> pickImage(BuildContext context) async {
    String? filePath;

    if (kIsWeb || Platform.isWindows) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null) filePath = result.files.single.path!;
    } else {
      ImageSource? imageSource = await selectImageSource(context);
      if (imageSource != null) {
        await ImagePicker().pickImage(source: imageSource).then((xFile) async {
          if (xFile != null) {
            filePath = xFile.path;
          } else {
            AlertMaker.showSimpleAlertDialog(
              context: context,
              title: intl.warning,
              content: intl.youDidntChooseAnyMedia,
              isWarning: true,
            );
          }
        });
      }
    }
    return filePath;
  }

  static Future<ImageSource?> selectImageSource(BuildContext context) async {
    ImageSource? imageSource;

    // Change nav bar color
    Future.delayed(const Duration(milliseconds: 200)).then(
      (value) => SystemChrome.setSystemUIOverlayStyle(
        Styles.systemUiOverlayStyle.copyWith(
          systemNavigationBarColor: primaryColorSurfaceTint,
        ),
      ),
    );

    await showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: Dimensions.roundedBorderTopBig,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Text(
              intl.chooseImageSource,
              style: TextStyle(color: Styles.primaryColor),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      imageSource = ImageSource.camera;
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Row(
                        children: [
                          const Icon(Icons.camera_alt),
                          const SizedBox(width: 20),
                          Text(intl.camera),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      imageSource = ImageSource.gallery;
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Row(
                        children: [
                          const Icon(Icons.photo_library_outlined),
                          const SizedBox(width: 20),
                          Text(intl.gallery),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

    // Restore theme style
    Future.delayed(const Duration(milliseconds: 200)).then(
      (value) => SystemChrome.setSystemUIOverlayStyle(
        Styles.systemUiOverlayStyle,
      ),
    );

    return imageSource;
  }
}
