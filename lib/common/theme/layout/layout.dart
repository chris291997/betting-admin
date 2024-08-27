part of '../theme.dart';

class AppLayout {
  const AppLayout._({
    required this.smallPadding,
    required this.mediumPadding,
    required this.largePadding,
    required this.smallRadius,
    required this.mediumRadius,
    required this.largeRadius,
    required this.smallSpacing,
    required this.mediumSpacing,
    required this.largeSpacing,
    required this.lowElevation,
    required this.mediumElevation,
    required this.highElevation,
  });

  final double smallPadding;
  final double mediumPadding;
  final double largePadding;
  final double smallRadius;
  final double mediumRadius;
  final double largeRadius;
  final double smallSpacing;
  final double mediumSpacing;
  final double largeSpacing;
  final double lowElevation;
  final double mediumElevation;
  final double highElevation;

  static AppLayout get layout {
    return const AppLayout._(
      smallPadding: 8.0,
      mediumPadding: 16.0,
      largePadding: 24.0,
      smallRadius: 4.0,
      mediumRadius: 8.0,
      largeRadius: 16.0,
      smallSpacing: 4.0,
      mediumSpacing: 8.0,
      largeSpacing: 16.0,
      lowElevation: 2.0,
      mediumElevation: 4.0,
      highElevation: 8.0,
    );
  }
}
