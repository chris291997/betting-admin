part of '../di/user_service_locator.dart';
abstract interface class UserRepositoryInterface {
  Future<UserOutput> createUser({required CreateUserInput input});
  Future<UserOutput> deleteUser({required String userId});
  Future<UserOutput> updateUser(
      {required String userId, required UpdateUserInput input});
  Future<UserOutput> getUser({required String userId});
  Future<List<UserOutput>> getUsers();
  Future<UserOutput> getLoggedUser();
}
