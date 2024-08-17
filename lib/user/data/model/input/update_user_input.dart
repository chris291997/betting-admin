part of '../../di/user_service_locator.dart';

class UpdateUserInput extends UserInput {
  const UpdateUserInput({
    required super.userType,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.userName,
    required super.createdBy,
  });

  const UpdateUserInput.empty()
      : super(
          userType: '',
          firstName: '',
          middleName: '',
          lastName: '',
          userName: '',
          createdBy: '',
        );

  UpdateUserInput copyWith({
    String? userType,
    String? firstName,
    String? middleName,
    String? lastName,
    String? userName,
    String? createdBy,
  }) {
    return UpdateUserInput(
      userType: userType ?? super.userType,
      firstName: firstName ?? super.firstName,
      middleName: middleName ?? super.middleName,
      lastName: lastName ?? super.lastName,
      userName: userName ?? super.userName,
      createdBy: createdBy ?? super.createdBy,
    );
  }
}
