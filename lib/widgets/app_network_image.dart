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
    Widget child = Image.network(url,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        double? progress;
        if (withProgress && loadingProgress.expectedTotalBytes != null) {
          progress = loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!;
        }
        
        return Center(
          child: CircularProgressIndicator(
            value: progress,
          ),
        );
      },
    );

    if (onPress != null) {
      child = InkWell(
        onTap: onPress,
        child: child,
      );
    }

    return child;
  }
}