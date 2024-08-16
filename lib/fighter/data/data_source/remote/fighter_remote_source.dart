part of '../../di/fighter_service_locator.dart';

class FighterRemoteSource {
  const FighterRemoteSource(this._manager);

  final NetworkManager _manager;

  static const String fighterPath = '/fighters';

  Future<FighterOutput> createFighter(
      {required CreateFighterInput input}) async {
    final response = await _manager.post(
      fighterPath,
      data: input.toJson(),
    );

    return FighterOutput.fromJson(response.data);
  }

  Future<FighterOutput> updateFighter(
      {required String fighterId, required UdpateFighterInput input}) async {
    final response = await _manager.post(
      '$fighterPath/update/$fighterId',
      data: input.toJson(),
    );

    return FighterOutput.fromJson(response.data);
  }

  Future<void> deleteFighter({required String fighterId}) async {
    await _manager.delete(
      '$fighterPath/$fighterId',
    );
  }

  Future<List<FighterOutput>> getFighters() async {
    final response = await _manager.get(
      fighterPath,
    );

    final List<dynamic> data = response.data as List<dynamic>;

    return data
        .map((json) => FighterOutput.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
