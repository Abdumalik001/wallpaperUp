import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/data/bloc/search/search_bloc.dart';
import 'package:wallpaper_hub/ui/utils/widgets.dart';

class SearchPage extends StatefulWidget {
  final String searchText;

  SearchPage(this.searchText);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc bloc;
  int currentPerPage = 1;
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    bloc = SearchBloc();
    controller.text = widget.searchText;
    //  FocusScope.of(context).requestFocus(FocusNode());
    bloc.add(SearchEvent(controller.text, currentPerPage));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('next page');
        currentPerPage ++;
        bloc.add(SearchEvent(controller.text, currentPerPage));
        print('currentPerPage=$currentPerPage');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.close();
    super.dispose();
    // bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:Theme.of(context).primaryColor,
        elevation: 0,
        title: titleAppbarWidget(context),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            margin: EdgeInsets.symmetric(horizontal: 24,vertical: 5),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                  ),
                ),
                GestureDetector(
                  child: Icon(Icons.search),
                  onTap: () {
                    bloc.add(SearchEvent(controller.text, currentPerPage));
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<SearchBloc, SearchState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is SearchInitial) return SizedBox();

              if (state is SearchLoadingState)
                return Center(
                  child: CircularProgressIndicator(),
                );
              if (state is SearchErrorState)
                return Center(
                    child: Text(
                  state.message.toString(),
                  style: TextStyle(color: Colors.red),
                ));

              if (state is SearchLoadedState) {
                var list = state.searchList;
                return photosWidget(list, context, _scrollController,false);
              }

              throw Exception('$state is not found');
            },
          )
        ],
      ),
    );
  }
}
