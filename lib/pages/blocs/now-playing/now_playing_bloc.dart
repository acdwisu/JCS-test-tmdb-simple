import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jcs_test/models/paginated-data.dart';
import 'package:jcs_test/models/request-state-enum.dart';
import 'package:meta/meta.dart';

import '../../../models/movie-item.dart';
import '../../../services/repository/movie-repository.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final MovieRepository movieRepository;

  NowPlayingBloc({required this.movieRepository}) : super(NowPlayingState.initial()) {
    on<RequestNowPlayingEvent>(_onReqNowPlaying);
  }

  FutureOr<void> _onReqNowPlaying(RequestNowPlayingEvent event, Emitter<NowPlayingState> emit) async {
    emit(state.copyWith(
      status: RequestState.Loading
    ));

    final temp = await movieRepository.nowPlaying(
      page: event.page
    );

    temp.fold(
      (l) => emit(state.copyWith(
        status: RequestState.Error,
        data: null
      )),
      (r) => emit(state.copyWith(
        status: RequestState.Loaded,
        data: r,
      )),
    );
  }
}
