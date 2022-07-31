class MovieVideoModel {
  final int id;
  final Iterable<MovieVideoItemModel> results;

  MovieVideoModel({required this.id, required this.results});

  factory MovieVideoModel.fromMap(Map m) =>
      MovieVideoModel(
          id: m['id'],
          results: (m['results'] as List)
              .map((e) => MovieVideoItemModel.fromJson(e))
      );
}

class MovieVideoItemModel {
  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  MovieVideoItemModel({required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id});

  factory MovieVideoItemModel.fromJson(Map m) =>
      MovieVideoItemModel(
          iso6391: m['iso_639_1'],
          iso31661: m['iso_3166_1'],
          name: m['name'],
          key: m['key'],
          site: m['site'],
          size: m['size'],
          type: m['type'],
          official: m['official'],
          publishedAt: m['published_at'],
          id: m['id']);
}
