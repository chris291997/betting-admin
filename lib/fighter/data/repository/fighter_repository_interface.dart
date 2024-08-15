part of '../di/fighter_service_locator.dart';

abstract interface class FighterRepositoryInterface {
  Future<FighterOutput> createFighter({required CreateFighterInput input});
  Future<FighterOutput> updateFighter(
      {required String fighterId, required UdpateFighterInput input});
  Future<void> deleteFighter({required String fighterId});
  Future<List<FighterOutput>> getFighters();
}
