part of '../di/fight_service_locator.dart';

abstract interface class FightRepositoryInterface {
  Future<FightOutput> createFight({
    required String eventId,
    required CreateFightInput input,
  });

  Future<void> deleteFight({required String eventId, required String fightId});

  Future<FightOutput> updateFight(
      {required String eventId,
      required String fightId,
      required UpdateFightInput input});

  Future<List<FightOutput>> getFights({required String eventId});

  Future<FightOutput> getFightById({
    required String eventId,
    required String fightId,
  });

  Future<void> startFight({
    required String eventId,
    required String fightId,
  });

  Future<void> concludeFight({
    required String eventId,
    required String fightId,
    required String winnerId,
  });

  Future<void> drawFight({
    required String eventId,
    required String fightId,
  });

  Future<void> cancelFight({
    required String eventId,
    required String fightId,
  });

  Future<void> closeBets({
    required String eventId,
    required String fightId,
  });

  Future<void> openBets({
    required String eventId,
    required String fightId,
  });
}
