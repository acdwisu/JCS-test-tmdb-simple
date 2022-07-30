class ProductionCompanyModel {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  ProductionCompanyModel({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry});

  factory ProductionCompanyModel.fromMap(Map m) =>
      ProductionCompanyModel(
          id: m['id'],
          name: m['name'],
          logoPath: m['logo_path'],
          originCountry: m['origin_country']);
}