import '/models/all_models.dart';

class User {
  final String id;
  final String name;
  final String password;
  final Settings settings;
  final List<Game> games;

  const User({
    this.id = '',
    this.name = '',
    this.password = '',
    this.settings = const Settings(),
    this.games = const [],
  });

  User copy({
    String? id,
    String? name,
    String? password,
    Settings? settings,
    List<Game>? games,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        password: password ?? this.password,
        settings: settings ?? this.settings,
        games: games ?? this.games,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        password: json['password'],
        settings: Settings.fromJson(json['settings']),
        games:
            json['games']?.map<Game>((game) => Game.fromJson(game))?.toList() ??
                <Game>[],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'password': password,
        'settings': settings.toJson(),
        'games': games.map((game) => game.toJson()).toList(),
      };

  @override
  String toString() => 'User{id: $id, name: $name}';
}
