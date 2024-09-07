import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/user/data/di/user_service_locator.dart';
import 'package:bet/user/presentation/component/first_name_field.dart';
import 'package:bet/user/presentation/component/last_name_field.dart';
import 'package:bet/user/presentation/component/middle_name_field.dart';
import 'package:bet/user/presentation/component/role_dropdown_field.dart';
import 'package:bet/user/presentation/component/user_create_or_update_button.dart';
import 'package:bet/user/presentation/component/username_field.dart';
import 'package:flutter/material.dart';

class UserModal extends StatelessWidget {
  const UserModal({
    super.key,
    required this.type,
    required this.onRoleChanged,
    required this.createtOrUpdateButtonState,
    required this.onFirstNameChanged,
    required this.onMiddleNameChanged,
    required this.onLastNameChanged,
    required this.onUsernameChanged,
    required this.onCreatedByChanged,
    required this.createOrUpdateButtonOnPressed,
    this.initialUserValue = const UserOutput(),
  });

  final UserModalType type;
  final PrimaryButtonState createtOrUpdateButtonState;
  final UserOutput initialUserValue;
  final Function(String) onRoleChanged;
  final Function(String) onFirstNameChanged;
  final Function(String) onMiddleNameChanged;
  final Function(String) onLastNameChanged;
  final Function(String) onUsernameChanged;
  final Function(String) onCreatedByChanged;
  final Function() createOrUpdateButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    final buttonLabel = type.isAdd ? "Add" : "Update";
    return AlertDialog(
      title: Text("$buttonLabel User"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoleDropdownField(
              initialValue: initialUserValue.type.name,
              onRoleChanged: onRoleChanged,
            ),
            const SizedBox(height: 5),
            FirstNameField(
              initialValue: initialUserValue.firstName,
              onFirstNameChanged: onFirstNameChanged,
            ),
            const SizedBox(height: 5),
            MiddleNameField(
              initialValue: initialUserValue.middleName,
              onMiddleNameChanged: onMiddleNameChanged,
            ),
            const SizedBox(height: 5),
            LastNameField(
              initialValue: initialUserValue.lastName,
              onLastNameChanged: onLastNameChanged,
            ),
            const SizedBox(height: 5),
            UsernameField(
              initialValue: initialUserValue.username,
              onUsernameChanged: onUsernameChanged,
            ),
            // const SizedBox(height: 5),
            // CreatedByField(
            //   initialValue: initialUserValue.createdBy,
            //   onCreatedByChanged: onCreatedByChanged,
            // ),
            const SizedBox(height: 20),
            UserCreateOrUpdateButton(
              createOrUpdateButtonOnPressed: createOrUpdateButtonOnPressed,
              submitButtonState: createtOrUpdateButtonState,
              buttonLabel: buttonLabel,
            ),
          ],
        ),
      ),
    );
  }
}

enum UserModalType {
  add,
  edit;

  bool get isAdd => this == UserModalType.add;
  bool get isEdit => this == UserModalType.edit;
}
