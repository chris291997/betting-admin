import 'package:bet/common/di/service_locator.dart';
import 'package:bet/common/abstract/json_serializable.dart';
import 'package:bet/common/helper/extension/json.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part '../data_source/remote/fight_remote_source.dart';
part '../model/base_model/fight_input.dart';
part '../model/input/create_fight_input.dart';
part '../model/input/update_fight_input.dart';
part '../model/output/fight_output.dart';
part '../repository/fight_repository.dart';
part '../repository/fight_repository_interface.dart';

final fightRemoteSource = FightRemoteSource(networkManager);
final fightRepository = FightRepository(
  fightRemoteSource,
);
