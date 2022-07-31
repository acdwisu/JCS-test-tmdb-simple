part of 'now_playing_bloc.dart';

@immutable
class NowPlayingState {
  final RequestState status;
  final PaginatedData<MovieItemModel>? data;

  NowPlayingState({required this.status, required this.data});

  factory NowPlayingState.initial() => NowPlayingState(
    status: RequestState.Empty,
    data: null,
  );

  NowPlayingState copyWith(
    {
      RequestState? status,
      PaginatedData<MovieItemModel>? data,
    }) => NowPlayingState(status: status ?? this.status, data: data);
}
