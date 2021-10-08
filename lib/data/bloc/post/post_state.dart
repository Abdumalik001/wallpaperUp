part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  bool hasNextPage;
  bool isLoadingMore;
  final List<Photos> photos;
  PostSuccess({required this.photos,  this.isLoadingMore = false, required this.hasNextPage});
}

class PostFail extends PostState {
  final String message;
  PostFail({required this.message});
}


