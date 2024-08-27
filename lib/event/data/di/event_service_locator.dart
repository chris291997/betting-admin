import 'package:bet/common/di/service_locator.dart';
import 'package:bet/common/abstract/json_serializable.dart';
import 'package:bet/common/helper/extension/json.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part '../data_source/remote/event_remote_source.dart';
part '../model/base_model/event_input.dart';
part '../model/input/create_event_input.dart';
part '../model/input/update_event_input.dart';
part '../model/output/event_output.dart';
part '../repository/event_repository.dart';
part '../repository/event_repository_interface.dart';

final eventRemoteSource = EventRemoteSource(networkManager);
final eventRepository = EventRepository(
  eventRemoteSource,
);
