import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../env.dart';
import '../../utils/dimensions.dart';
import '../../utils/language/localization.dart';
import '../../utils/theme/theme_styles.dart';

class ApiImageWidget extends StatelessWidget {
  final String? imageFilename;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final bool isCircular;

  const ApiImageWidget({
    super.key,
    required this.imageFilename,
    this.height,
    this.width,
    this.boxFit,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return imageFilename != null
        ? CachedNetworkImage(
            key: Key(imageFilename.toString()),
            height: height,
            width: width,
            cacheKey: imageFilename.toString(),
            imageUrl: "$imagesUrl/$imageFilename",
            imageBuilder: (context, imageProvider) {
              return isCircular
                  ? CircleAvatar(backgroundImage: imageProvider)
                  : Container(
                      color: darkColor,
                      child: Image(
                        image: imageProvider,
                        fit: boxFit,
                      ),
                    );
            },
            progressIndicatorBuilder: (context, url, progress) {
              return Center(
                child: SpinKitFadingCircle(
                  color: Styles.primaryColor,
                  size: 50.0,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return _buildErrorWidget(
                height: height,
                width: width,
                isCircular: isCircular,
              );
            },
          )
        : _buildNoImageWidget(
            height: height,
            width: width,
            isCircular: isCircular,
          );
  }

  static Widget _buildErrorWidget({
    double? height,
    double? width,
    bool isCircular = false,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: isCircular
          ? const CircleAvatar(
              backgroundImage: AssetImage("assets/images/no-profile-pic.png"),
            )
          : Container(
              decoration: BoxDecoration(
                color: darkColor.withOpacity(0.6),
                borderRadius: Dimensions.roundedBorderMedium,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.broken_image_outlined,
                    color: lightColor,
                    size: 60,
                  ),
                  Text(
                    intl.couldntLoadImage,
                    style: const TextStyle(color: lightColor),
                  )
                ],
              ),
            ),
    );
  }

  static Widget _buildNoImageWidget({
    double? height,
    double? width,
    bool isCircular = false,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: isCircular
          ? const CircleAvatar(
              backgroundImage: AssetImage("assets/images/no-profile-pic.png"),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: Dimensions.roundedBorderMedium,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image_outlined,
                    color: lightColor,
                    size: 60,
                  ),
                  Text(
                    intl.noImage,
                    style: const TextStyle(color: lightColor),
                  )
                ],
              ),
            ),
    );
  }
}
