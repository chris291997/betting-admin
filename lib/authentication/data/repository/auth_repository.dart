part of '../di/auth_service_locator.dart';

class AuthRepository implements AuthRepositoryInterface {
  const AuthRepository(
    this._remoteSource,
    this._localSource,
    this._userRemoteSource,
  );

  final AuthRemoteSource _remoteSource;
  final AuthLocalSource _localSource;
  final UserRemoteSource _userRemoteSource;

  @override
  Future<void> login({required AuthInput input}) async {
    final output = await _remoteSource.login(input: input);

    await _localSource.saveTokens(output);
  }

  @override
  Future<void> logout() async {
    await _localSource.deleteTokens();
  }
}
