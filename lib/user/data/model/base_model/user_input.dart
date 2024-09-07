part of '../../di/user_service_locator.dart';

class UserInput extends Equatable {
  const UserInput({
    required this.userType,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.userName,
    required this.createdBy,
  });

  final String userType;
  final String firstName;
  final String middleName;
  final String lastName;
  final String userName;
  final String createdBy;

  factory UserInput.fromJson(Map<String, dynamic> json) {
    return UserInput(
      userType: json['userType'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      lastName: json['lastName'] as String,
      userName: json['userName'] as String,
      createdBy: json['createdBy'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // convert userType to pascal case
      'userType': userType.isNotEmpty
          ? userType[0].toUpperCase() + userType.substring(1)
          : 'None',
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'userName': userName,
      'createdBy': createdBy,
    };
  }

  @override
  List<Object> get props =>
      [userType, firstName, middleName, lastName, userName, createdBy];
}
