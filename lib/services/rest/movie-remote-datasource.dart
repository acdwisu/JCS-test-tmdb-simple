import 'package:jcs_test/models/detail.dart';
import 'package:jcs_test/models/genre.dart';
import 'package:jcs_test/models/movie-item.dart';

import '../../models/movie-video.dart';
import '../../models/paginated-data-ranged-time.dart';
import '../../models/paginated-data.dart';
import '../../models/search-result.dart';

abstract class MovieRemoteDataSource {
  Future<PaginatedData<SearchResultModel>> search({
    required String query,
    int? page,
    String? language,
    bool? includeAdult,
    String? region,
    int? year,
    int? primaryReleaseYear,
  });
  Future<MovieVideoModel> videos({
    required int movieId,
    String? language
  });
  Future<Iterable<GenreModel>> genres({String? language});
  Future<DetailModel> detail({
    required int movieId,
    String? language,
    String? appendToRespond
  });
  Future<PaginatedDataRangedTime<MovieItemModel>> nowPlaying({
    String? language,
    String? region,
    int? page,
  });
  Future<PaginatedData<MovieItemModel>> popular({
    String? language,
    String? region,
    int? page,
  });
  Future<PaginatedData<MovieItemModel>> topRated({
    String? language,
    String? region,
    int? page,
  });
  Future<PaginatedData<MovieItemModel>> upcoming({
    String? language,
    String? region,
    int? page,
  });
}