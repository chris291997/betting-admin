import 'package:flutter/material.dart';

class FighterDetails extends StatelessWidget {
  const FighterDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Meron'),
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
