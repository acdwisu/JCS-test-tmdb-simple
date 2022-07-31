part of 'top_rated_bloc.dart';

@immutable
class TopRatedState {
  final RequestState status;
  final PaginatedData<MovieItemModel>? data;

  TopRatedState({required this.status, required this.data});

  factory TopRatedState.initial() => TopRatedState(
    status: RequestState.Empty,
    data: null,
  );

  TopRatedState copyWith(
    {
      RequestState? status,
      PaginatedData<MovieItemModel>? data,
    }) => TopRatedState(status: status ?? this.status, data: data);
}
