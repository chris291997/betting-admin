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
  Future<void> deleteFight(
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

  @override
  Future<FightOutput> getFightById({
    required String eventId,
    required String fightId,
  }) async {
    return _remoteSource.getFightById(eventId: eventId, fightId: fightId);
  }

  @override
  Future<void> startFight({
    required String eventId,
    required String fightId,
  }) async {
    return await _remoteSource.startFight(eventId: eventId, fightId: fightId);
  }

  @override
  Future<void> concludeFight({
    required String eventId,
    required String fightId,
    required String winnerId,
  }) async {
    return await _remoteSource.concludeFight(
      eventId: eventId,
      fightId: fightId,
      winnerId: winnerId,
    );
  }

  @override
  Future<void> drawFight({
    required String eventId,
    required String fightId,
  }) async {
    return await _remoteSource.drawFight(eventId: eventId, fightId: fightId);
  }

  @override
  Future<void> cancelFight({
    required String eventId,
    required String fightId,
  }) async {
    return await _remoteSource.cancelFight(eventId: eventId, fightId: fightId);
  }

  @override
  Future<void> closeBets({
    required String eventId,
    required String fightId,
  }) async {
    return await _remoteSource.closeBets(eventId: eventId, fightId: fightId);
  }

  @override
  Future<void> openBets({
    required String eventId,
    required String fightId,
  }) async {
    return await _remoteSource.openBets(eventId: eventId, fightId: fightId);
  }
}
