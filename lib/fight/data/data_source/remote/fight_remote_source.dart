part of '../../di/fight_service_locator.dart';

class FightRemoteSource {
  const FightRemoteSource(this._manager);

  final NetworkManager _manager;

  static const String eventPath = '/event';
  static const String fightPath = '/fights';

  Future<FightOutput> createFight(
      {required String eventId, required CreateFightInput input}) async {
    final response = await _manager.post(
      '$eventPath/$eventId$fightPath',
      data: input.toJson(),
    );

    return FightOutput.fromJson(response.data);
  }

  Future<FightOutput> deleteFight(
      {required String eventId, required String fightId}) async {
    final response = await _manager.delete(
      '$eventPath/$eventId$fightPath/$fightId',
    );

    return FightOutput.fromJson(response.data);
  }

  Future<FightOutput> updateFight(
      {required String eventId,
      required String fightId,
      required UpdateFightInput input}) async {
    final response = await _manager.post(
      '$eventPath/$eventId$fightPath/$fightId',
      data: input.toJson(),
    );

    return FightOutput.fromJson(response.data);
  }

  Future<List<FightOutput>> getFights({required String eventId}) async {
    final response = await _manager.post(
      '$eventPath/$eventId$fightPath',
    );

    final List<dynamic> data = response.data as List<dynamic>;

    return data
        .map((json) => FightOutput.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
