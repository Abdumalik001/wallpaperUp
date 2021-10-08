import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_hub/data/models/photos_model.dart';
import 'package:wallpaper_hub/data/services/servise.dart';


part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());

  final NetworkService _net = NetworkService();

  List<Photos> photos = [];
  List<Photos> searchPhoto = [];
  bool hasNextPage = false;

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is GetPostEvent) {
      print("event page :"+event.page.toString());
      try {
        hasNextPage =await _net.getHasNextPage();
        print('has nextPage $hasNextPage');
        if (photos.length == 0) {
          yield PostLoading();
          photos = (await _net.getCuratedPosts(event.page))!;
          yield PostSuccess(photos: photos, hasNextPage: hasNextPage);
        }
        if (hasNextPage) {
          yield PostSuccess(photos: photos, isLoadingMore: true, hasNextPage:hasNextPage );
          var list = await _net.getCuratedPosts(event.page);

          photos.addAll(list!);
          print('list size : ${photos.length}');
          yield PostSuccess(photos: photos, hasNextPage: hasNextPage);
        }
      } catch (e) {
        yield PostFail(message: e.toString());
      }
    }

    // if (event is GetSearchEvent) {
    //   yield PostLoading();
    //
    //   try {
    //     searchPhoto = await _net.getSearchList(event.searchText, event.);
    //     yield PostSuccess(photos: searchPhoto);
    //   } catch (e) {
    //     yield PostFail(message: e.toString());
    //   }
    // }

    // if (event is NextPageEvent) {
    //   yield PostLoading();
    //
    //   try {
    //     var list = await _net.getCuratedPosts(+);
    //     photos.addAll(list);
    //     yield  PostSuccess(photos: searchPhoto);
    //   } catch (e) {
    //     yield PostFail(message: e.toString());
    //   }
    // }
  }
}
