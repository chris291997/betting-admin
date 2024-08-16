import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RoleDropdownField extends HookWidget {
  const RoleDropdownField({
    super.key,
    required this.onRoleChanged,
    this.initialValue = '',
  });
  final String initialValue;
  final Function(String) onRoleChanged;

  @override
  Widget build(BuildContext context) {
    final role = useState(initialValue);

    return DropdownButton<String>(
      value: role.value.isEmpty ? 'None' : role.value,
      items: <String>[
        'None',
        'Pos',
        'Admin',
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newRole) {
        onRoleChanged(newRole ?? 'None');

        role.value = newRole ?? role.value;
      },
    );
  }
}
