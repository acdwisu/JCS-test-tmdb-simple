import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:jcs_test/pages/blocs/detail/detail_bloc.dart';
import 'package:jcs_test/services/repository/movie-repository.dart';
import 'package:jcs_test/services/rest/movie-http-datasource.dart';
import 'package:jcs_test/services/rest/movie-remote-datasource.dart';
import 'package:jcs_test/services/utils/network_info.dart';

import 'pages/blocs/now-playing/now_playing_bloc.dart';
import 'pages/blocs/popular/popular_bloc.dart';
import 'pages/blocs/top-rated/top_rated_bloc.dart';
import 'pages/blocs/upcoming/upcoming_bloc.dart';

final locator = GetIt.instance;

void initInjection() {
  //datasources
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieHttpDatasource(
    httpClient: Client(),
  ));
  
  //repository
  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
    networkInfo: locator(),
    movieRemoteDataSource: locator(),
  ));
  
  //utils
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
    locator()
  ));
  locator.registerLazySingleton(() => DataConnectionChecker());
  
  //bloc
  locator.registerFactory(() => NowPlayingBloc(
    movieRepository: locator()
  ));
  locator.registerFactory(() => TopRatedBloc(
      movieRepository: locator()
  ));
  locator.registerFactory(() => PopularBloc(
      movieRepository: locator()
  ));
  locator.registerFactory(() => UpcomingBloc(
      movieRepository: locator()
  ));
  locator.registerFactory(() => DetailBloc(
      movieRepository: locator()
  ));
}