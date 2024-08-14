import 'package:bet/common/di/service_locator.dart';
import 'package:bet/user/data/model/output/user.dart';

class UserRemoteSource {
  const UserRemoteSource(this._manager);

  final NetworkManager _manager;

  static const String userPath = '/Users';

  Future<User> getLoggedUser() async {
    final response = await _manager.get(
      '$userPath/me',
    );

    return User.fromJson(response.data);
  }

  Future<User> getUserById({required String id}) async {
    final response = await _manager.get(
      '$userPath/$id',
    );

    return User.fromJson(response.data);
  }

  Future<List<User>> fetchUsers() async {
    final response = await _manager.get(
      userPath,
    );

    return (response.data as List)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
