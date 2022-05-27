class PlayersScoreModel{
  dynamic score;
  dynamic gamesNumber;
  String uid;
  String name;
  String token;

  PlayersScoreModel({
    required this.score,
    required this.gamesNumber,
    required this.uid,
    required this.name,
    required this.token,
  });

  Map<String, dynamic> toMap(PlayersScoreModel playersScoreModel) {
    Map<String, dynamic> playersScoreMap = Map();
    playersScoreMap['score'] = playersScoreModel.score;
    playersScoreMap['gamesNumber'] = playersScoreModel.gamesNumber;
    playersScoreMap['uid'] = playersScoreModel.uid;
    playersScoreMap['name'] = playersScoreModel.name;
    playersScoreMap['token'] = playersScoreModel.token;
    return playersScoreMap;
  }

  factory PlayersScoreModel.fromMap( map) {
    return PlayersScoreModel(
      score: map['score']  ,
      gamesNumber: map['gamesNumber'] ,
      uid: map['uid'] as String,
      name: map['name'] as String,
      token: map['token'] as String,
    );
  }
}