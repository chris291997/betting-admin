part of '../../di/user_service_locator.dart';

class UserRemoteSource {
  const UserRemoteSource(this._manager);

  final NetworkManager _manager;

  static const String userPath = '/users';

  Future<UserOutput> getLoggedUser() async {
    final response = await _manager.get(
      '$userPath/me',
    );

    return UserOutput.fromJson(response.data);
  }

  Future<UserOutput> createUser({required CreateUserInput input}) async {
    final response = await _manager.post(
      userPath,
      data: input.toJson(),
    );

    return UserOutput.fromJson(response.data);
  }

  Future<UserOutput> updateUser(
      {required userId, required UpdateUserInput input}) async {
    final response = await _manager.patch(
      '$userPath/update/$userId',
      data: input.toJson(),
    );

    return UserOutput.fromJson(response.data);
  }

  Future<UserOutput> deleteUser({required String id}) async {
    final response = await _manager.delete(
      '$userPath/$id',
    );

    return UserOutput.fromJson(response.data);
  }

  Future<UserOutput> getUserById({required String id}) async {
    final response = await _manager.get(
      '$userPath/$id',
    );

    return UserOutput.fromJson(response.data);
  }

  Future<List<UserOutput>> fetchUsers() async {
    final response = await _manager.get(
      userPath,
    );

    return (response.data as List)
        .map((e) => UserOutput.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<UserOutput> getUser({required String userId}) async {
    final response = await _manager.get(
      '$userPath/$userId',
    );

    return UserOutput.fromJson(response.data);
  }
}
