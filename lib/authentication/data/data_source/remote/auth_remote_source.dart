part of '../../di/auth_service_locator.dart';

class AuthRemoteSource {
  const AuthRemoteSource(this._manager);

  final NetworkManager _manager;

  static const String authPath = '/auth';

  Future<AuthOutput> login({required AuthInput input}) async {
    final response = await _manager.post(
      '$authPath/login',
      data: input.toJson(),
    );

    return AuthOutput.fromJson(response.data);
  }
}
