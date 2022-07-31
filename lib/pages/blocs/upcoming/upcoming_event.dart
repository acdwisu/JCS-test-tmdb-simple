part of 'upcoming_bloc.dart';

@immutable
abstract class UpcomingEvent {}

class RequestUpcomingEvent extends UpcomingEvent {
  final int page;

  RequestUpcomingEvent({required this.page});
}