import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/data/app_theme_data.dart';
import 'package:wallpaper_hub/data/bloc/post/post_bloc.dart';
import 'package:wallpaper_hub/data/bloc/theme/theme_bloc.dart';
import 'package:wallpaper_hub/data/models/category_model.dart';
import 'package:wallpaper_hub/ui/pages/search_page.dart';
import 'package:wallpaper_hub/ui/utils/drawer.dart';
import 'package:wallpaper_hub/ui/utils/utils.dart';
import 'package:wallpaper_hub/ui/utils/widgets.dart';

class HomePage extends StatefulWidget {
  static Widget page() => HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PostBloc bloc;
  late ThemeBloc themeBloc;
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  int currentPage = 2;
  List categoryList = getCategories();
  bool textFieldIsEmpty = false;
  bool isLight = true;

  @override
  void initState() {
    super.initState();
    controller.text = '';
    bloc = BlocProvider.of<PostBloc>(context);
    themeBloc = BlocProvider.of(context);
    bloc.add(GetPostEvent(currentPage));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('next page');
        currentPage++;
        bloc.add(GetPostEvent(currentPage));
        print('pages=' + currentPage.toString());
      }
      // bloc.add(GetPostEvent(currentPage));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( systemNavigationBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: MainDrawer(),
      appBar: AppBar(
        title: titleAppbarWidget(context),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: isLight
                  ? Icon(
                      Icons.nightlight_round,
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.wb_sunny,
                      color: Colors.yellow,
                    ),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  isLight = !isLight;
                });

                isLight
                    ? themeBloc.add(ThemeEvent(AppTheme.lightTheme))
                    : themeBloc.add(ThemeEvent(AppTheme.darkTheme));
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24,vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Icon(Icons.search),
                      onTap: () {
                        if (controller.text.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchPage(controller.text),
                              ));
                          setState(() {
                            textFieldIsEmpty = false;
                          });
                        } else {
                          setState(() {
                            textFieldIsEmpty = true;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
              textFieldIsEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Is empty',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 120,
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CarouselSlider(
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  initialPage: 2,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 2000)),
              items: List.generate(categoryList.length, (index) {
                return Builder(
                  builder: (context) {
                    return GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  categoryList[index].imgUrl.toString()),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: Text(
                            categoryList[index].categorieName.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //child: Image.network(categoryList[index].imgUrl.toString(),fit: BoxFit.cover,),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(
                                categoryList[index].categorieName.toString()),
                          ),
                        );
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostInitial) return SizedBox();
              if (state is PostLoading)
                return Center(child: CircularProgressIndicator());
              if (state is PostFail) return Center(child: Text(state.message));

              if (state is PostSuccess) {
                var list = state.photos;
                return photosWidget(
                    list, context, _scrollController, state.isLoadingMore);
              }

              return Center(child: Text('Nothing'));
            },
          ),
        ],
      ),
    );
  }
}

