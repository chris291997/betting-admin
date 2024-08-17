import 'package:bet/common/di/service_locator.dart';
import 'package:bet/user/data/di/user_service_locator.dart';
import 'package:equatable/equatable.dart';

part '../data_source/remote/auth_remote_source.dart';
part '../data_source/local/auth_local_source.dart';
part '../model/input/auth_input.dart';
part '../model/output/auth_output.dart';
part '../repository/auth_repository.dart';
part '../repository/auth_repository_interface.dart';

final authLocalSource = AuthLocalSource(cacheService);
final authRemoteSource = AuthRemoteSource(networkManager);
final authRepository = AuthRepository(
  authRemoteSource,
  authLocalSource,
  userRemoteSource,
);
