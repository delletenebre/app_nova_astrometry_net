import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(this.url, {
    Key? key,
    this.withProgress = false,
    this.onPress,
  }) : super(key: key);

  final String url;
  final bool withProgress;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    Widget child = CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Image(image: imageProvider),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
    // Image.network(url,
    //   loadingBuilder: (context, child, loadingProgress) {
    //     if (loadingProgress == null) {
    //       return child;
    //     }

    //     double? progress;
    //     if (withProgress && loadingProgress.expectedTotalBytes != null) {
    //       progress = loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!;
    //     }
        
    //     return Center(
    //       child: CircularProgressIndicator(
    //         value: progress,
    //       ),
    //     );
    //   },
    // );

    if (onPress != null) {
      child = InkWell(
        onTap: onPress,
        child: child,
      );
    }

    return child;
  }
}