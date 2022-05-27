class PlayersScoreModel{
  dynamic score;
  dynamic gamesNumber;
  String uid;
  String name;

  PlayersScoreModel({
    required this.score,
    required this.gamesNumber,
    required this.uid,
    required this.name,
  });

  Map<String, dynamic> toMap(PlayersScoreModel playersScoreModel) {
    Map<String, dynamic> playersScoreMap = Map();
    playersScoreMap['score'] = playersScoreModel.score;
    playersScoreMap['gamesNumber'] = playersScoreModel.gamesNumber;
    playersScoreMap['uid'] = playersScoreModel.uid;
    playersScoreMap['name'] = playersScoreModel.name;
    return playersScoreMap;
  }

  factory PlayersScoreModel.fromMap( map) {
    return PlayersScoreModel(
      score: map['score']  ,
      gamesNumber: map['gamesNumber'] ,
      uid: map['uid'] as String,
      name: map['name'] as String,
    );
  }
}