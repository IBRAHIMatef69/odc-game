class GameRoomModel {
  String firstPlayerId;
  String firstPlayerName;
  String secondPlayerId;
  String secondPlayerName;

  String playerTurnName;
  String lastPlayerID;
  List indexes;

  GameRoomModel({
    required this.firstPlayerId,
    required this.firstPlayerName,
    required this.secondPlayerId,
    required this.secondPlayerName,
    required this.playerTurnName,
    required this.lastPlayerID,
    required this.indexes,
  });

  Map<String, dynamic> toMap(GameRoomModel gameRoomModel) {
    Map<String, dynamic> gameMap = Map();

    gameMap['firstPlayerId'] = gameRoomModel.firstPlayerId;
    gameMap['firstPlayerName'] = gameRoomModel.firstPlayerName;
    gameMap['secondPlayerId'] = gameRoomModel.secondPlayerId;
    gameMap['secondPlayerName'] = gameRoomModel.secondPlayerName;

    gameMap['playerTurnName'] = gameRoomModel.playerTurnName;
    gameMap['lastPlayerID'] = gameRoomModel.lastPlayerID;
    gameMap['indexes'] = gameRoomModel.indexes;
    return gameMap;
  }

  factory GameRoomModel.fromMap(map) {
    return GameRoomModel(
      firstPlayerId: map['firstPlayerId'] as String,
      firstPlayerName: map['firstPlayerName'] as String,
      secondPlayerId: map['secondPlayerId'] as String,
      secondPlayerName: map['secondPlayerName'] as String,
      lastPlayerID: map['lastPlayerID'] as String,
      playerTurnName: map['playerTurnName'] as String,
      indexes: map['indexes'] as List,
    );
  }
}
