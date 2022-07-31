part of 'top_rated_bloc.dart';

@immutable
abstract class TopRatedEvent {}

class RequestTopRatedEvent extends TopRatedEvent {
  final int page;

  RequestTopRatedEvent({required this.page});
}