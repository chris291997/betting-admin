import 'package:bet/common/asset/image.dart';
import 'package:bet/common/theme/theme.dart';
import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 600,
        maxHeight: double.infinity,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.layout.largeRadius),
          image: const DecorationImage(
            image: AssetImage(AppImage.cockfight),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
