import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jcs_test/models/paginated-data.dart';
import 'package:jcs_test/models/request-state-enum.dart';
import 'package:meta/meta.dart';

import '../../../models/movie-item.dart';
import '../../../services/repository/movie-repository.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final MovieRepository movieRepository;

  PopularBloc({required this.movieRepository}) : super(PopularState.initial()) {
    on<RequestPopularEvent>(_onReqPopular);
  }

  FutureOr<void> _onReqPopular(RequestPopularEvent event, Emitter<PopularState> emit) async {
    emit(state.copyWith(
      status: RequestState.Loading
    ));

    final temp = await movieRepository.popular(
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
