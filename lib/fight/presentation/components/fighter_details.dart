import 'package:flutter/material.dart';

class FighterDetails extends StatelessWidget {
  const FighterDetails({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Meron: $id'),
        SizedBox(height: 30),
        Text('Name'),
        SizedBox(height: 10),
        Text('Weight'),
        SizedBox(height: 10),
        Text('Breed'),
        SizedBox(height: 10),
        Text('Owner'),
        SizedBox(height: 30),
        Text('Winner'),
      ],
    );
  }
}
