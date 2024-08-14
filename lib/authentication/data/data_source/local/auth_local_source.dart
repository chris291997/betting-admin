part of '../../di/auth_service_locator.dart';

class AuthLocalSource {
  const AuthLocalSource(this._cacheService);

  final CacheService _cacheService;

  Future<void> deleteTokens() async {
    await Future.wait([
      _cacheService.remove(StorageKey.accessToken),
      _cacheService.remove(StorageKey.refreshToken),
    ]);
  }

  Future<void> saveTokens(AuthOutput output) async {
    await Future.wait([
      _cacheService.write(StorageKey.accessToken, output.accessToken),
      _cacheService.write(StorageKey.refreshToken, output.refreshToken),
    ]);
  }
}
