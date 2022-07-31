import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:jcs_test/services/rest/movie-remote-datasource.dart';
import 'package:jcs_test/services/utils/failure.dart';

import '../../models/detail.dart';
import '../../models/genre.dart';
import '../../models/movie-item.dart';
import '../../models/movie-video.dart';
import '../../models/paginated-data-ranged-time.dart';
import '../../models/paginated-data.dart';
import '../../models/search-result.dart';
import '../utils/exception.dart';
import '../utils/network_info.dart';

abstract class MovieRepository {
  Future<Either<Failure, PaginatedData<SearchResultModel>>> search({
    required String query,
    int? page,
    String? language,
    bool? includeAdult,
    String? region,
    int? year,
    int? primaryReleaseYear,
  });

  Future<Either<Failure, MovieVideoModel>> videos(
      {required int movieId, String? language});

  Future<Either<Failure, Iterable<GenreModel>>> genres({String? language});

  Future<Either<Failure, DetailModel>> detail(
      {required int movieId, String? language, String? appendToRespond});

  Future<Either<Failure, PaginatedDataRangedTime<MovieItemModel>>> nowPlaying({
    String? language,
    String? region,
    int? page,
  });

  Future<Either<Failure, PaginatedData<MovieItemModel>>> popular({
    String? language,
    String? region,
    int? page,
  });

  Future<Either<Failure, PaginatedData<MovieItemModel>>> topRated({
    String? language,
    String? region,
    int? page,
  });

  Future<Either<Failure, PaginatedData<MovieItemModel>>> upcoming({
    String? language,
    String? region,
    int? page,
  });
}

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.movieRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DetailModel>> detail(
      {required int movieId, String? language, String? appendToRespond}) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ConnectionFailure());
      }

      final result =
          await movieRemoteDataSource.detail(
            movieId: movieId,
            language: language,
            appendToRespond: appendToRespond,
          );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e, trace) {
      log('error', error: e, stackTrace: trace);

      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Iterable<GenreModel>>> genres({String? language}) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ConnectionFailure());
      }

      final result =
          await movieRemoteDataSource.genres(
            language: language
          );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e, trace) {
      log('error', error: e, stackTrace: trace);

      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedDataRangedTime<MovieItemModel>>> nowPlaying(
      {String? language, String? region, int? page}) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ConnectionFailure());
      }

      final result =
          await movieRemoteDataSource.nowPlaying(
            language: language,
            page: page,
            region: region,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e, trace) {
      log('error', error: e, stackTrace: trace);

      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedData<MovieItemModel>>> popular(
      {String? language, String? region, int? page}) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ConnectionFailure());
      }

      final result =
          await movieRemoteDataSource.popular(
        language: language,
        page: page,
        region: region,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e, trace) {
      log('error', error: e, stackTrace: trace);

      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedData<SearchResultModel>>> search(
      {required String query,
      int? page,
      String? language,
      bool? includeAdult,
      String? region,
      int? year,
      int? primaryReleaseYear}) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ConnectionFailure());
      }

      final result =
          await movieRemoteDataSource.search(
        language: language,
        page: page,
        query: query,
        includeAdult: includeAdult,
        primaryReleaseYear: primaryReleaseYear,
        year: year,
        region: region,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e, trace) {
      log('error', error: e, stackTrace: trace);

      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedData<MovieItemModel>>> topRated(
      {String? language, String? region, int? page}) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ConnectionFailure());
      }

      final result =
          await movieRemoteDataSource.topRated(
        language: language,
        page: page,
        region: region,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e, trace) {
      log('error', error: e, stackTrace: trace);

      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedData<MovieItemModel>>> upcoming(
      {String? language, String? region, int? page}) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ConnectionFailure());
      }

      final result =
          await movieRemoteDataSource.upcoming(
        language: language,
        page: page,
        region: region,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e, trace) {
      log('error', error: e, stackTrace: trace);

      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieVideoModel>> videos(
      {required int movieId, String? language}) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ConnectionFailure());
      }

      final result =
          await movieRemoteDataSource.videos(
        language: language,
        movieId: movieId,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e, trace) {
      log('error', error: e, stackTrace: trace);

      return Left(CommonFailure(e.toString()));
    }
  }
}
