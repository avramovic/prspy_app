///
///
///
class Player {
  late String name;
  late int score;
  late int kills;
  late int deaths;
  int? team;
  late int ping;
  late bool isAi;
  String? clan;
  late String prStatsNormalizedPlayerName;

  ///
  ///
  ///
  Player({
    this.name = '',
    this.score = 0,
    this.kills = 0,
    this.deaths = 0,
    this.team,
    this.ping = 0,
    this.isAi = false,
  });

  ///
  ///
  ///
  Player.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    score = json['score'];
    kills = json['kills'];
    deaths = json['deaths'];
    team = json['team'];
    ping = json['ping'] ?? 0;
    isAi = json['isAi'] == 1;
    List<String> playerNameAndClam = name.split(' ');
    if (playerNameAndClam.length > 1 && playerNameAndClam.first.isNotEmpty) {
      clan = playerNameAndClam.first.trim();
      name = playerNameAndClam.last;
    }
    name = name.trim();
    prStatsNormalizedPlayerName = name.replaceAll('&', '%26');
  }

  ///
  ///
  ///
  String get playerName {
    String name = clan ?? '';
    name += ' ${this.name}';
    return name.trim();
  }
}
