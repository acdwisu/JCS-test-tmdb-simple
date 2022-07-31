part of 'upcoming_bloc.dart';

@immutable
class UpcomingState {
  final RequestState status;
  final PaginatedData<MovieItemModel>? data;

  UpcomingState({required this.status, required this.data});

  factory UpcomingState.initial() => UpcomingState(
    status: RequestState.Empty,
    data: null,
  );

  UpcomingState copyWith(
    {
      RequestState? status,
      PaginatedData<MovieItemModel>? data,
    }) => UpcomingState(status: status ?? this.status, data: data);
}
