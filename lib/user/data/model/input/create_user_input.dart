part of '../../di/user_service_locator.dart';

class CreateUserInput extends UserInput {
  const CreateUserInput({
    required super.userType,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.userName,
    required super.createdBy,
  });

  const CreateUserInput.empty()
      : super(
          userType: '',
          firstName: '',
          middleName: '',
          lastName: '',
          userName: '',
          createdBy: '',
        );

  CreateUserInput copyWith({
    String? userType,
    String? firstName,
    String? middleName,
    String? lastName,
    String? userName,
    String? createdBy,
  }) {
    return CreateUserInput(
      userType: userType ?? super.userType,
      firstName: firstName ?? super.firstName,
      middleName: middleName ?? super.middleName,
      lastName: lastName ?? super.lastName,
      userName: userName ?? super.userName,
      createdBy: createdBy ?? super.createdBy,
    );
  }
}
