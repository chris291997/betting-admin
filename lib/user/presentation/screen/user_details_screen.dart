import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Name: John Doe'),
            Text('Role: Admin'),
            Text('Username: johndoe'),
            Text('Created By: Admin'),
          ],
        ),
      ),
    );
  }
}
