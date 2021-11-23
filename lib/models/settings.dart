class Settings {
  final bool isCreator;

  const Settings({
    this.isCreator = false,
  });

  Settings copy({
    required bool isCreator,
  }) =>
      Settings(isCreator: isCreator);

  static Settings fromJson(Map<String, dynamic> json) => Settings(
        isCreator: json['isCreator'],
      );

  Map<String, dynamic> toJson() => {
        'isCreator': isCreator,
      };
}
