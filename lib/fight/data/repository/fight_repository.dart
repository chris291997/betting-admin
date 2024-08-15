part of '../di/fight_service_locator.dart';

class FightRepository implements FightRepositoryInterface {
  const FightRepository(
    this._remoteSource,
  );

  final FightRemoteSource _remoteSource;

  @override
  Future<FightOutput> createFight(
      {required String eventId, required CreateFightInput input}) async {
    return _remoteSource.createFight(eventId: eventId, input: input);
  }

  @override
  Future<FightOutput> deleteFight(
      {required String eventId, required String fightId}) async {
    return _remoteSource.deleteFight(eventId: eventId, fightId: fightId);
  }

  @override
  Future<FightOutput> updateFight(
      {required String eventId,
      required String fightId,
      required UpdateFightInput input}) async {
    return _remoteSource.updateFight(
        eventId: eventId, fightId: fightId, input: input);
  }

  @override
  Future<List<FightOutput>> getFights({required String eventId}) async {
    return _remoteSource.getFights(eventId: eventId);
  }
}
