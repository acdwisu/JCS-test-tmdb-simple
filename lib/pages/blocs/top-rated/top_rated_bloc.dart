import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jcs_test/models/paginated-data.dart';
import 'package:jcs_test/models/request-state-enum.dart';
import 'package:meta/meta.dart';

import '../../../models/movie-item.dart';
import '../../../services/repository/movie-repository.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final MovieRepository movieRepository;

  TopRatedBloc({required this.movieRepository}) : super(TopRatedState.initial()) {
    on<RequestTopRatedEvent>(_onReqTopRated);
  }

  FutureOr<void> _onReqTopRated(RequestTopRatedEvent event, Emitter<TopRatedState> emit) async {
    emit(state.copyWith(
      status: RequestState.Loading
    ));

    final temp = await movieRepository.topRated(
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
