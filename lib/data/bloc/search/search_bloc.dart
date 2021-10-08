import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_hub/data/models/photos_model.dart';
import 'package:wallpaper_hub/data/services/servise.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  NetworkService service = NetworkService();
  List<Photos> searchList = [];

  // bool? hasNextPage;

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchEvent) {
      // hasNextPage = await service.getHasNextPage();
      print(await service.getHasNextPage());
      try {
        if (searchList.isEmpty) {
          yield SearchLoadingState();
          searchList =
              await service.getSearchList(event.searchText, event.page);
          yield SearchLoadedState(searchList: searchList);
        }
        if (true) {
          yield SearchLoadedState(searchList: searchList, isLoadingMore: true);
          var list = await service.getSearchList(event.searchText, event.page);
          searchList.addAll(list);
          yield SearchLoadedState(searchList: searchList);
        }
      } catch (e) {
        yield SearchErrorState(
          e.toString(),
        );
      }
    }
  }
}
