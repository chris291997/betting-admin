import 'package:bet/common/di/service_locator.dart';
import 'package:bet/common/helper/extension/json.dart';
import 'package:equatable/equatable.dart';

part '../data_source/remote/user_remote_source.dart';
part '../model/base_model/user_input.dart';
part '../model/input/create_user_input.dart';
part '../model/input/update_user_input.dart';
part '../model/output/user_output.dart';
part '../repository/user_repository.dart';
part '../repository/user_repository_interface.dart';

final userRemoteSource = UserRemoteSource(networkManager);
final userRepository = UserRepository(
  userRemoteSource,
);
