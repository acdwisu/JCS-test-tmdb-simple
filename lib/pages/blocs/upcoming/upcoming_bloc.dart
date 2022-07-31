import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jcs_test/models/paginated-data.dart';
import 'package:jcs_test/models/request-state-enum.dart';
import 'package:meta/meta.dart';

import '../../../models/movie-item.dart';
import '../../../services/repository/movie-repository.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final MovieRepository movieRepository;

  UpcomingBloc({required this.movieRepository}) : super(UpcomingState.initial()) {
    on<RequestUpcomingEvent>(_onReqUpcoming);
  }

  FutureOr<void> _onReqUpcoming(RequestUpcomingEvent event, Emitter<UpcomingState> emit) async {
    emit(state.copyWith(
      status: RequestState.Loading
    ));

    final temp = await movieRepository.upcoming(
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
