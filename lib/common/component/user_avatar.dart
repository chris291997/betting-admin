import 'package:bet/common/theme/theme.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.firstName,
    required this.lastName,
    super.key,
  });

  final String firstName;
  final String lastName;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: context.colors.primary,
      child: (firstName.isEmpty || lastName.isEmpty)
          ? Icon(
              Icons.person,
              color: context.colors.onPrimary,
            )
          : Text(
              '${firstName[0]}${lastName[0]}',
              style: context.textStyle.headline6.copyWith(
                color: context.colors.onPrimary,
              ),
            ),
    );
  }
}
