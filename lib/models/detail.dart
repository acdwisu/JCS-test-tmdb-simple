import 'package:jcs_test/models/movie-detail-status-enum.dart';

import 'genre.dart';
import 'production-company.dart';
import 'production-country.dart';
import 'spoken-lang.dart';

class DetailModel {
  final bool adult;
  final String? backdropPath;
  final int budget;
  final Iterable<GenreModel> genres;
  final String? homePage;
  final int id;
  final String? imdbId;
  final String oriLang;
  final String oriTitle;
  final String? overview;
  final num popularity;
  final String? posterPath;
  final Iterable<ProductionCompanyModel> productionCompanies;
  final Iterable<ProductionCountryModel> productionCountries;
  final String releaseDate;
  final int revenue;
  final int? runtime;
  final Iterable<SpokenLangModel> spokenLanguages;
  final MovieDetailStatus status;
  final String? tagLine;
  final String title;
  final bool video;
  final num voteAvg;
  final int voteCount;

  DetailModel({required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homePage,
    required this.id,
    required this.imdbId,
    required this.oriLang,
    required this.oriTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagLine,
    required this.title,
    required this.video,
    required this.voteAvg,
    required this.voteCount});

  factory DetailModel.fromMap(Map m) {
    final genres = m['genres'] as List;
    final productionCompanies = m['production_companies'] as List;
    final productionCountries = m['production_countries'] as List;
    final spokenLangs = m['spoken_languages'] as List;
    final status = m['status'];

    return DetailModel(
      adult: m['adult'],
      backdropPath: m['backdrop_path'],
      budget: m['budget'],
      genres: genres.map((e) => GenreModel.fromJson(e)),
      homePage: m['homepage'],
      id: m['id'],
      imdbId: m['imdb_id'],
      oriLang: m['original_language'],
      oriTitle: m['original_title'],
      overview: m['overview'],
      popularity: m['popularity'],
      posterPath: m['poster_path'],
      productionCompanies: productionCompanies.map((e) => ProductionCompanyModel.fromMap(e)),
      productionCountries: productionCountries.map((e) => ProductionCountryModel.fromJson(e)),
      releaseDate: m['release_date'],
      revenue: m['revenue'],
      runtime: m['runtime'],
      spokenLanguages: spokenLangs.map((e) => SpokenLangModel.fromJson(e)),
      status: movieDetailStatusFromString(status),
      tagLine: m['tagline'],
      title: m['title'],
      video: m['video'],
      voteAvg: m['vote_average'],
      voteCount: m['vote_count'],
    );
  }
}
