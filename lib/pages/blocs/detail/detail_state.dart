part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailError extends DetailState {
  final String message;

  DetailError({required this.message});
}

class DetailLoaded extends DetailState {
  final DetailModel model;
  final MovieVideoModel? video;
  final RequestState videoStatus;

  DetailLoaded({required this.model, required this.video, required this.videoStatus});
}
