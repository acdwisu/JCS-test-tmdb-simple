class SearchResultModel {
  final String? posterPath;
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<int> genreIds;
  final int id;
  final String oriTitle;
  final String oriLang;
  final String title;
  final String? backdropPath;
  final num popularity;
  final int voteCount;
  final bool video;
  final num voteAvg;

  SearchResultModel(
      {required this.posterPath,
      required this.adult,
      required this.overview,
      required this.releaseDate,
      required this.genreIds,
      required this.id,
      required this.oriTitle,
      required this.oriLang,
      required this.title,
      required this.backdropPath,
      required this.popularity,
      required this.voteCount,
      required this.video,
      required this.voteAvg});
  
  factory SearchResultModel.fromMap(Map m) => SearchResultModel(
      posterPath: m['poster_path'],
      adult: m['adult'],
      overview: m['overview'],
      releaseDate: m['release_date'],
      genreIds: m['genre_ids'],
      id: m['id'],
      oriTitle: m['original_title'],
      oriLang: m['original_language'],
      title: m['title'],
      backdropPath: m['backdrop_path'],
      popularity: m['popularity'],
      voteCount: m['vote_count'],
      video: m['video'],
      voteAvg: m['vote_average']
  );
}
