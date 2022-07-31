part of 'now_playing_bloc.dart';

@immutable
abstract class NowPlayingEvent {}

class RequestNowPlayingEvent extends NowPlayingEvent {
  final int page;

  RequestNowPlayingEvent({required this.page});
}