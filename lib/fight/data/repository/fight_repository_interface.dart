part of '../di/fight_service_locator.dart';

abstract interface class FightRepositoryInterface {
  Future<FightOutput> createFight(
      {required String eventId, required CreateFightInput input});

  Future<FightOutput> deleteFight(
      {required String eventId, required String fightId});

  Future<FightOutput> updateFight(
      {required String eventId,
      required String fightId,
      required UpdateFightInput input});
  Future<List<FightOutput>> getFights({required String eventId});
}
