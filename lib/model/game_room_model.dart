class GameRoomModel {
  String firstPlayerId;
  String firstPlayerName;
  String secondPlayerId;
  String secondPlayerName;

  String playerTurnName;
  String lastPlayerID;
  List indexes;
  List firstPlayerMoves;
  List secondPlayerMoves;

  GameRoomModel({
    required this.firstPlayerId,
    required this.firstPlayerName,
    required this.secondPlayerId,
    required this.secondPlayerName,
    required this.playerTurnName,
    required this.lastPlayerID,
    required this.firstPlayerMoves,
    required this.secondPlayerMoves,
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
    gameMap['firstPlayerMoves'] = gameRoomModel.firstPlayerMoves;
    gameMap['secondPlayerMoves'] = gameRoomModel.secondPlayerMoves;
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
      firstPlayerMoves: map['firstPlayerMoves'] as List,
      secondPlayerMoves: map['secondPlayerMoves'] as List,
    );
  }
}
