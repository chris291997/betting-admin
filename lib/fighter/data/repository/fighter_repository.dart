part of '../di/fighter_service_locator.dart';

class FighterRepository implements FighterRepositoryInterface {
  const FighterRepository(
    this._remoteSource,
  );

  final FighterRemoteSource _remoteSource;

  @override
  Future<FighterOutput> createFighter(
      {required CreateFighterInput input}) async {
    return _remoteSource.createFighter(input: input);
  }

  @override
  Future<FighterOutput> updateFighter(
      {required String fighterId, required UdpateFighterInput input}) async {
    return _remoteSource.updateFighter(fighterId: fighterId, input: input);
  }

  @override
  Future<void> deleteFighter({required String fighterId}) async {
    return _remoteSource.deleteFighter(fighterId: fighterId);
  }

  @override
  Future<List<FighterOutput>> getFighters() async {
    return _remoteSource.getFighters();
  }
}
