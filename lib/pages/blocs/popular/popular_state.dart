part of 'popular_bloc.dart';

@immutable
class PopularState {
  final RequestState status;
  final PaginatedData<MovieItemModel>? data;

  PopularState({required this.status, required this.data});

  factory PopularState.initial() => PopularState(
    status: RequestState.Empty,
    data: null,
  );

  PopularState copyWith(
    {
      RequestState? status,
      PaginatedData<MovieItemModel>? data,
    }) => PopularState(status: status ?? this.status, data: data);
}
