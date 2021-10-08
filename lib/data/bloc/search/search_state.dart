part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  bool isLoadingMore;
  final List<Photos> searchList;
  bool? hasNextPage;

  SearchLoadedState({ required this.searchList, this.isLoadingMore=false, this.hasNextPage});
}

class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState(this.message);
}
