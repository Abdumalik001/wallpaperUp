part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetPostEvent extends PostEvent {
  int page;

  GetPostEvent(this.page);
}

class GetSearchEvent extends PostEvent {
  final String searchText;

  GetSearchEvent(this.searchText);
}

class NextPageEvent extends PostEvent {}
