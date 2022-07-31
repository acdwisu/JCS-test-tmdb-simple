part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class RequestDetailEvent extends DetailEvent {
  final int movieId;

  RequestDetailEvent({required this.movieId});
}
