import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:jcs_test/models/detail.dart';
import 'package:jcs_test/models/genre.dart';
import 'package:jcs_test/models/movie-item.dart';
import 'package:jcs_test/models/movie-video.dart';
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

  final _apiVersion = '3';
  final _endPointMovie = 'movie';
  final _endPointGenre = 'genre';
  final _endPointList = 'list';
  final _endPointVideos = 'videos';
  final _endPointNowPlaying = 'now_playing';
  final _endPointPopular = 'popular';
  final _endPointTopRated = 'top_rated';
  final _endPointUpcoming = 'upcoming';
  final _endPointSearch = 'search';

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
        Uri.https(baseUrlApi,
          "/$_apiVersion/$_endPointMovie/$movieId",
          {
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
      Uri.https(baseUrlApi,
          "/$_apiVersion/$_endPointGenre/$_endPointMovie/$_endPointList",
          {
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
      Uri.https(baseUrlApi, "/$_apiVersion/$_endPointMovie/$_endPointNowPlaying",
          {
            if(language!=null)
              'language': language,
            if(region!=null)
              'region': region,
            if(page!=null)
              'page': page.toString(),
          }
      ),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return PaginatedDataRangedTime(
        page: decoded['page'],
        totalPages: decoded['total_pages'],
        totalResults: decoded['total_results'],
        minimumDate: decoded['dates']['minimum'],
        maximumDate: decoded['dates']['maximum'],
        data: (decoded['results'] as List)
            .map((e) => MovieItemModel.fromJson(e))
      );
    }

    throw ServerException();
  }

  @override
  Future<PaginatedData<MovieItemModel>> popular(
      {String? language, String? region, int? page}) async {
    final response = await _client.get(
      Uri.https(baseUrlApi,
          "/$_apiVersion/$_endPointMovie/$_endPointPopular",
          {
            if(language!=null)
              'language': language,
            if(region!=null)
              'region': region,
            if(page!=null)
              'page': page.toString(),
          }
      ),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return PaginatedData(
          page: decoded['page'],
          totalPages: decoded['total_pages'],
          totalResults: decoded['total_results'],
          data: (decoded['results'] as List)
              .map((e) => MovieItemModel.fromJson(e))
      );
    }

    throw ServerException();
  }

  @override
  Future<PaginatedData<SearchResultModel>> search(
      {required String query,
      int? page,
      String? language,
      bool? includeAdult,
      String? region,
      int? year,
      int? primaryReleaseYear}) async {
    final response = await _client.get(
      Uri.https(baseUrlApi, "/$_apiVersion/$_endPointSearch/$_endPointMovie",
          {
            'query': query,
            if(language!=null)
              'language': language,
            if(region!=null)
              'region': region,
            if(page!=null)
              'page': page.toString(),
            if(includeAdult!=null)
              'include_adult': includeAdult.toString(),
            if(year!=null)
              'year': year.toString(),
            if(primaryReleaseYear!=null)
              'primary_release_year': primaryReleaseYear.toString(),
          }
      ),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return PaginatedData(
          page: decoded['page'],
          totalPages: decoded['total_pages'],
          totalResults: decoded['total_results'],
          data: (decoded['results'] as List)
              .map((e) => SearchResultModel.fromJson(e))
      );
    }

    throw ServerException();
  }

  @override
  Future<PaginatedData<MovieItemModel>> topRated(
      {String? language, String? region, int? page}) async {
    final response = await _client.get(
      Uri.https(baseUrlApi,
          "/$_apiVersion/$_endPointMovie/$_endPointTopRated",
          {
            if(language!=null)
              'language': language,
            if(region!=null)
              'region': region,
            if(page!=null)
              'page': page.toString(),
          }
      ),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return PaginatedData(
          page: decoded['page'],
          totalPages: decoded['total_pages'],
          totalResults: decoded['total_results'],
          data: (decoded['results'] as List)
              .map((e) => MovieItemModel.fromJson(e))
      );
    }

    throw ServerException();
  }

  @override
  Future<PaginatedData<MovieItemModel>> upcoming(
      {String? language, String? region, int? page}) async {
    final response = await _client.get(
      Uri.https(baseUrlApi,
          "/$_apiVersion/$_endPointMovie/$_endPointUpcoming",
          {
            if(language!=null)
              'language': language,
            if(region!=null)
              'region': region,
            if(page!=null)
              'page': page.toString(),
          }
      ),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return PaginatedData(
          page: decoded['page'],
          totalPages: decoded['total_pages'],
          totalResults: decoded['total_results'],
          data: (decoded['results'] as List)
              .map((e) => MovieItemModel.fromJson(e))
      );
    }

    throw ServerException();
  }

  @override
  Future<MovieVideoModel> videos({required int movieId, String? language}) async {
    final response = await _client.get(
      Uri.https(baseUrlApi,
          "/$_apiVersion/$_endPointMovie/$movieId/$_endPointVideos",
          {
            if(language!=null)
              'language': language,
          }
      ),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return MovieVideoModel.fromMap(decoded);
    }

    throw ServerException();
  }
}
