part of '../di/auth_service_locator.dart';

abstract interface class AuthRepositoryInterface {
  Future<void> login({required AuthInput input});
  Future<void> logout();
}
