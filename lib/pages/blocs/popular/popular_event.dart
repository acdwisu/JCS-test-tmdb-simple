part of 'popular_bloc.dart';

@immutable
abstract class PopularEvent {}

class RequestPopularEvent extends PopularEvent {
  final int page;

  RequestPopularEvent({required this.page});
}