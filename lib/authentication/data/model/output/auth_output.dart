part of '../../di/auth_service_locator.dart';

class AuthOutput extends Equatable {
  const AuthOutput({
    this.accessToken = '',
    this.refreshToken = '',
  });

  final String accessToken;
  final String refreshToken;

  static const empty = AuthOutput();

  bool get isEmpty => this == AuthOutput.empty;

  factory AuthOutput.fromJson(Map<String, dynamic> json) {
    return AuthOutput(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  @override
  List<Object> get props => [accessToken, refreshToken];
}
