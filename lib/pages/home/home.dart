import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jcs_test/models/menu-enum.dart';
import 'package:jcs_test/models/request-state-enum.dart';
import 'package:jcs_test/pages/blocs/now-playing/now_playing_bloc.dart';
import 'package:jcs_test/pages/blocs/top-rated/top_rated_bloc.dart';
import 'package:jcs_test/pages/home/card-tiles.dart';

import '../../services/utils/common.dart';
import '../../shared/card-tile.dart';
import '../blocs/popular/popular_bloc.dart';
import '../blocs/upcoming/upcoming_bloc.dart';

class HomePage extends StatefulWidget {
  final void Function(MenuOption) menuSelectHandler;

  const HomePage({Key? key, required this.menuSelectHandler}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _fetchData();
      },
      child: ListView(
        children: [
          BlocBuilder<NowPlayingBloc, NowPlayingState>(
            builder: (context, state) {
              return CardTiles(
                title: 'Now Playing',
                bigItems: true,
                moreTrigger: () {
                  widget.menuSelectHandler(MenuOption.NowPlaying);
                },
                refreshTrigger: () {
                  context.read<NowPlayingBloc>().add(
                      RequestNowPlayingEvent(page: 1));
                },
                items: state.data?.data,
              );
            },
          ),
          BlocBuilder<TopRatedBloc, TopRatedState>(
            builder: (context, state) {
              return CardTiles(
                title: 'Top Rated',
                bigItems: false,
                moreTrigger: () {
                  widget.menuSelectHandler(MenuOption.TopRated);
                },
                refreshTrigger: () {
                  context.read<TopRatedBloc>().add(
                      RequestTopRatedEvent(page: 1));
                },
                items: state.data?.data,
              );
            },
          ),
          BlocBuilder<PopularBloc, PopularState>(
            builder: (context, state) {
              return CardTiles(
                title: 'Popular',
                bigItems: false,
                moreTrigger: () {
                  widget.menuSelectHandler(MenuOption.Popular);
                },
                refreshTrigger: () {
                  context.read<PopularBloc>().add(
                      RequestPopularEvent(page: 1));
                },
                items: state.data?.data,
              );
            },
          ),
          BlocBuilder<UpcomingBloc, UpcomingState>(
            builder: (context, state) {
              return CardTiles(
                title: 'Upcoming',
                bigItems: false,
                moreTrigger: () {
                  widget.menuSelectHandler(MenuOption.Upcoming);
                },
                refreshTrigger: () {
                  context.read<UpcomingBloc>().add(
                      RequestUpcomingEvent(page: 1));
                },
                items: state.data?.data,
              );
            },
          ),
        ],
      ),
    );
  }

  void _fetchData() {
    context.read<UpcomingBloc>().add(
        RequestUpcomingEvent(page: 1));
    context.read<PopularBloc>().add(
        RequestPopularEvent(page: 1));
    context.read<TopRatedBloc>().add(
        RequestTopRatedEvent(page: 1));
    context.read<NowPlayingBloc>().add(
        RequestNowPlayingEvent(page: 1));
  }
}
