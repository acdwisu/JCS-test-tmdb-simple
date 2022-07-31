import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jcs_test/models/menu-enum.dart';
import 'package:jcs_test/models/request-state-enum.dart';
import 'package:jcs_test/pages/blocs/now-playing/now_playing_bloc.dart';
import 'package:jcs_test/pages/blocs/now-playing/now_playing_bloc.dart';
import 'package:jcs_test/pages/blocs/top-rated/top_rated_bloc.dart';
import 'package:jcs_test/pages/home/card-tiles.dart';
import 'package:jcs_test/pages/search/search-delegate.dart';

import '../../models/search-result.dart';
import '../../shared/drawer.dart';
import '../blocs/popular/popular_bloc.dart';
import '../blocs/upcoming/upcoming_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
              Icons.menu
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () async {
              final temp = await showSearch<SearchResultModel?>(
                  context: context,
                  delegate: MovieSearcher()
              );
            },
          )
        ],
      ),
      drawer: DrawerMenu(
        menuOption: MenuOption.Home,
        drawerCloser: () {
          _scaffoldKey.currentState?.closeDrawer();
        },
      ),
      body: ListView(
        children: [
          BlocBuilder<NowPlayingBloc, NowPlayingState>(
            builder: (context, state) {
              if (state.status == RequestState.Empty) {
                context.read<NowPlayingBloc>().add(
                    RequestNowPlayingEvent(page: 1));
              }

              return CardTiles(
                title: 'Now Playing',
                bigItems: true,
                moreTrigger: () {

                },
                refreshTrigger: () {
                  context.read<NowPlayingBloc>().add(
                      RequestNowPlayingEvent(page: 1));
                },
                items: state.data?.data.map((e) => CardTileItem(
                    title: e.title,
                    releaseDate: e.releaseDate,
                    posterUrl: e.posterPath,
                    vote: e.voteAvg*10
                )),
              );
            },
          ),
          BlocBuilder<TopRatedBloc, TopRatedState>(
            builder: (context, state) {
              if (state.status == RequestState.Empty) {
                context.read<TopRatedBloc>().add(
                    RequestTopRatedEvent(page: 1));
              }

              return CardTiles(
                title: 'Top Rated',
                bigItems: false,
                moreTrigger: () {

                },
                refreshTrigger: () {
                  context.read<TopRatedBloc>().add(
                      RequestTopRatedEvent(page: 1));
                },
                items: state.data?.data.map((e) => CardTileItem(
                    title: e.title,
                    releaseDate: e.releaseDate,
                    posterUrl: e.posterPath,
                    vote: e.voteAvg*10
                )),
              );
            },
          ),
          BlocBuilder<PopularBloc, PopularState>(
            builder: (context, state) {
              if (state.status == RequestState.Empty) {
                context.read<PopularBloc>().add(
                    RequestPopularEvent(page: 1));
              }

              return CardTiles(
                title: 'Popular',
                bigItems: false,
                moreTrigger: () {

                },
                refreshTrigger: () {
                  context.read<PopularBloc>().add(
                      RequestPopularEvent(page: 1));
                },
                items: state.data?.data.map((e) => CardTileItem(
                    title: e.title,
                    releaseDate: e.releaseDate,
                    posterUrl: e.posterPath,
                    vote: e.voteAvg*10
                )),
              );
            },
          ),
          BlocBuilder<UpcomingBloc, UpcomingState>(
            builder: (context, state) {
              if (state.status == RequestState.Empty) {
                context.read<UpcomingBloc>().add(
                    RequestUpcomingEvent(page: 1));
              }

              return CardTiles(
                title: 'Upcoming',
                bigItems: false,
                moreTrigger: () {

                },
                refreshTrigger: () {
                  context.read<UpcomingBloc>().add(
                      RequestUpcomingEvent(page: 1));
                },
                items: state.data?.data.map((e) => CardTileItem(
                    title: e.title,
                    releaseDate: e.releaseDate,
                    posterUrl: e.posterPath,
                    vote: e.voteAvg*10
                )),
              );
            },
          ),
        ],
      ),
    );
  }
}
