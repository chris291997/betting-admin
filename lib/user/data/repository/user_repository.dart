part of '../di/user_service_locator.dart';

class UserRepository implements UserRepositoryInterface {
  const UserRepository(
    this._remoteSource,
  );

  final UserRemoteSource _remoteSource;

  @override
  Future<UserOutput> createUser({required CreateUserInput input}) async {
    return _remoteSource.createUser(input: input);
  }

  @override
  Future<UserOutput> deleteUser({required String userId}) async {
    return _remoteSource.deleteUser(id: userId);
  }

  @override
  Future<UserOutput> updateUser(
      {required String userId, required UpdateUserInput input}) async {
    return _remoteSource.updateUser(userId: userId, input: input);
  }

  @override
  Future<UserOutput> getUser({required String userId}) async {
    return _remoteSource.getUser(userId: userId);
  }

  @override
  Future<List<UserOutput>> getUsers() async {
    return _remoteSource.fetchUsers();
  }

  @override
  Future<UserOutput> getLoggedUser() async {
    return _remoteSource.getLoggedUser();
  }
}
