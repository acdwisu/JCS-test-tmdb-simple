class NowPlayingModel {
  final String? posterPath;
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLang;
  final String title;
  final String? backdropPath;
  final num popularity;
  final int voteCount;
  final bool video;
  final num voteAvg;

  NowPlayingModel({required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLang,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAvg});

  factory NowPlayingModel.fromJson(Map m) =>
      NowPlayingModel(posterPath: m['poster_path'],
          adult: m['adult'],
          overview: m['overview'],
          releaseDate: m['release_date'],
          genreIds: m['genre_ids'],
          id: m['id'],
          originalTitle: m['original_title'],
          originalLang: m['original_language'],
          title: m['title'],
          backdropPath: m['backdrop_path'],
          popularity: m['popularity'],
          voteCount: m['vote_count'],
          video: m['video'],
          voteAvg: m['voteAvg']);
}