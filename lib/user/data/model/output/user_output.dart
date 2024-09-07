part of '../../di/user_service_locator.dart';

class UserOutput extends Equatable implements JsonSerializable {
  const UserOutput({
    this.id = '',
    this.type = UserType.none,
    this.firstName = '',
    this.middleName = '',
    this.lastName = '',
    this.username = '',
    this.createdBy = '',
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final UserType type;
  final String firstName;
  final String middleName;
  final String lastName;
  final String username;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  static const UserOutput empty = UserOutput(
    id: '',
    type: UserType.pos,
    firstName: '',
    middleName: '',
    lastName: '',
    username: '',
    createdBy: '',
  );

  factory UserOutput.fromJson(Map<String, dynamic> json) {
    return UserOutput(
      id: json.parseString('id'),
      type: UserType.fromString(json.parseString('userType')),
      firstName: json.parseString('firstName'),
      middleName: json.parseString('middleName'),
      lastName: json.parseString('lastName'),
      username: json.parseString('userName'),
      createdBy: json.parseString('createdBy'),
      createdAt: json.parseDateTime('createdAt'),
      updatedAt: json.parseDateTime('updatedAt'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'userName': username,
      'createdBy': createdBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  Map<String, dynamic> toTableJson() {
    return {
      'userType': type.name,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'userName': username,
      'createdBy': createdBy,
    };
  }

  UserOutput copyWith({
    String? id,
    UserType? type,
    String? firstName,
    String? middleName,
    String? lastName,
    String? username,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserOutput(
      id: id ?? this.id,
      type: type ?? this.type,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isNotEmpty => this != UserOutput.empty;
  bool get isEmpty => !isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        type,
        firstName,
        middleName,
        lastName,
        username,
        createdBy,
        createdAt,
        updatedAt,
      ];
}

enum UserType {
  none,
  pos,
  admin;

  bool get isNone => this == UserType.none;

  bool get isPos => this == UserType.pos;

  bool get isAdmin => this == UserType.admin;

  String get value {
    switch (this) {
      case UserType.none:
        return 'None';
      case UserType.pos:
        return 'Pos';
      case UserType.admin:
        return 'Admin';
    }
  }

  static UserType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'none':
        return UserType.none;
      case 'pos':
        return UserType.pos;
      case 'admin':
        return UserType.admin;
      default:
        return UserType.none;
    }
  }
}
