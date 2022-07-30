class SpokenLangModel {
  final String iso6391;
  final String name;

  SpokenLangModel({
    required this.iso6391,
    required this.name});

  factory SpokenLangModel.fromJson(Map m) => SpokenLangModel(
      iso6391: m['iso_639_1'],
      name: m['name']);
}