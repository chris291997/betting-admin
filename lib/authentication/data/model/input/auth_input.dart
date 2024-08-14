part of '../../di/auth_service_locator.dart';

class AuthInput extends Equatable {
  const AuthInput({
    this.username = '',
    this.password = '',
  });

  final String username;
  final String password;

  static const empty = AuthInput();

  bool get isEmpty => this == AuthInput.empty;

  AuthInput copyWith({
    String? username,
    String? password,
  }) {
    return AuthInput(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  @override
  List<Object> get props => [username, password];
}
