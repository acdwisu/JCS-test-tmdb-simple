import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jcs_test/models/detail.dart';
import 'package:jcs_test/models/movie-video.dart';
import 'package:meta/meta.dart';

import '../../../models/request-state-enum.dart';
import '../../../services/repository/movie-repository.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final MovieRepository movieRepository;

  DetailBloc({required this.movieRepository}) : super(DetailInitial()) {
    on<RequestDetailEvent>(_onReqDetail);
  }

  FutureOr<void> _onReqDetail(RequestDetailEvent event, Emitter<DetailState> emit) async {
    emit(DetailLoading());

    final result = await movieRepository.detail(
      movieId: event.movieId,
    );

    final completer = Completer();

    result.fold(
      (l) => emit(DetailError(message: l.message)),
      (r) async {
        final video = await movieRepository.videos(movieId: event.movieId);

        video.fold(
          (l) => emit(DetailLoaded(
            model: r,
            video: null,
            videoStatus: RequestState.Error,
          )),
          (r2) => emit(DetailLoaded(
            model: r,
            video: r2,
            videoStatus: RequestState.Loaded,
          ))
        );

        completer.complete();
      }
    );

    await completer.future;
  }
}
