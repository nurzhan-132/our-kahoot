import 'settings.dart';

class User {
  final String id;
  final String name;
  final String password;
  final DateTime dateOfBirth;
  final String imagePath;
  final Settings settings;

  const User({
    this.id = '',
    this.name = '',
    this.password = '',
    required this.dateOfBirth,
    this.imagePath = '',
    this.settings = const Settings(),
  });

  User copy({
    String? id,
    String? name,
    String? password,
    DateTime? dateOfBirth,
    String? imagePath,
    Settings? settings,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        password: password ?? this.password,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        imagePath: imagePath ?? this.imagePath,
        settings: settings ?? this.settings,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        password: json['password'],
        dateOfBirth: DateTime.tryParse(json['dateOfBirth']) ?? DateTime.now(),
        imagePath: json['imagePath'],
        settings: Settings.fromJson(json['settings']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'password': password,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'imagePath': imagePath,
        'settings': settings.toJson(),
      };

  @override
  String toString() => 'User{id: $id, name: $name}';
}
