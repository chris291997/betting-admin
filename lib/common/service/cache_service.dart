part of '../di/service_locator.dart';

class CacheService {
  const CacheService();

  Future<String?> read(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  Future<void> write(String key, String value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  Future<void> remove(String key) async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
}

class StorageKey {
  const StorageKey._();

  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
}
