class ProductionCountryModel {
  final String iso31661;
  final String name;

  ProductionCountryModel({
    required this.iso31661,
    required this.name});

  factory ProductionCountryModel.fromJson(Map m) => ProductionCountryModel(
      iso31661: m['iso_3166_1'],
      name: m['name']);
}