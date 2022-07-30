import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:jcs_test/models/detail.dart';
import 'package:jcs_test/models/genre.dart';
import 'package:jcs_test/models/movie-item.dart';
import 'package:jcs_test/models/paginated-data-ranged-time.dart';
import 'package:jcs_test/models/paginated-data.dart';
import 'package:jcs_test/models/search-result.dart';
import 'package:jcs_test/services/rest/movie-remote-datasource.dart';
import 'package:jcs_test/services/utils/constant.dart';

import '../utils/exception.dart';
import 'interceptor/api-key.dart';
import 'interceptor/logging.dart';

class MovieHttpDatasource extends MovieRemoteDataSource {
  final Client _client;

  final _endPointMovie = 'movie';
  final _endPointGenre = 'genre';
  final _endPointList = 'list';

  MovieHttpDatasource._(this._client);

  factory MovieHttpDatasource({
    required Client httpClient,
  }) {
    final temp = InterceptedClient.build(
      interceptors: [
        LoggingInterceptor(),
        ApiKeyInterceptor(),
      ],
      client: httpClient,
      requestTimeout: const Duration(seconds: 20),
    );

    return MovieHttpDatasource._(temp);
  }

  @override
  Future<DetailModel> detail(
      {required int movieId, String? language, String? appendToRespond}) async {
    final response = await _client.get(
        Uri(
          path: "$baseUrlApi$_endPointMovie$movieId",
          queryParameters: {
            if(language!=null)
              'language': language,
            if(appendToRespond!=null)
              'append_to_response': appendToRespond,
          }
        ),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return DetailModel.fromMap(decoded);
    }

    throw ServerException();
  }

  @override
  Future<Iterable<GenreModel>> genres({String? language}) async {
    final response = await _client.get(
      Uri(
          path: "$baseUrlApi$_endPointGenre/$_endPointMovie/$_endPointList",
          queryParameters: {
            if(language!=null)
              'language': language,
          }
      ),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return (decoded as List).map((e) => GenreModel.fromJson(e));
    }

    throw ServerException();
  }

  @override
  Future<PaginatedDataRangedTime<MovieItemModel>> nowPlaying(
      {String? language, String? region, int? page}) async {
    final response = await _client.get(
      Uri(
          path: "$baseUrlApi$_endPointGenre/$_endPointMovie/$_endPointList",
          queryParameters: {
            if(language!=null)
              'language': language,
          }
      ),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return (decoded as List).map((e) => GenreModel.fromJson(e));
    }

    throw ServerException();
  }

  @override
  Future<PaginatedData<MovieItemModel>> popular(
      {String? language, String? region, int? page}) {
    // TODO: implement popular
    throw UnimplementedError();
  }

  @override
  Future<PaginatedData<SearchResultModel>> search(
      {required String query,
      int? page,
      String? language,
      bool? includeAdult,
      String? region,
      int? year,
      int? primaryReleaseYear}) {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<PaginatedData<MovieItemModel>> topRated(
      {String? language, String? region, int? page}) {
    // TODO: implement topRated
    throw UnimplementedError();
  }

  @override
  Future<PaginatedData<MovieItemModel>> upcoming(
      {String? language, String? region, int? page}) {
    // TODO: implement upcoming
    throw UnimplementedError();
  }
}
