import 'package:bet/common/asset/image.dart';
import 'package:flutter/cupertino.dart';

class ImageLoader {
  const ImageLoader._();

  static Future<void> load(BuildContext context) async {
    await _loadImageAssets(
      context,
      path: [
        AppImage.cockfight,
      ],
    );
  }

  static Future<void> _loadImageAssets(
    BuildContext context, {
    required List<String> path,
  }) async {
    for (final imagePath in path) {
      await _loadImageAsset(context, path: imagePath);
    }
  }

  static Future<void> _loadImageAsset(
    BuildContext context, {
    required String path,
  }) async {
    await precacheImage(AssetImage(path), context);
  }
}
