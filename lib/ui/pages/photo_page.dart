import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub/data/models/photos_model.dart';
import 'package:wallpaper_hub/data/services/save_photo.dart';

class PhotoPage extends StatefulWidget {
  final List<Photos> listPhoto;
  final int currentIndex;

  PhotoPage({required this.listPhoto, required this.currentIndex});

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  CarouselController controller = CarouselController();
  int? _currentPageIndex;

  @override
  void initState() {
    super.initState();
    SavePhoto().requestPermission();
  }

  @override
  void dispose() {
    //widget.listPhoto.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            carouselController: controller,
            items: widget.listPhoto.map((e) {
              //  print('index :${widget.currentIndex}');
              return Builder(
                builder: (context) {
                  return CachedNetworkImage(
                    imageUrl: e.src!.portrait.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: double.infinity,
              initialPage: widget.currentIndex,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPageIndex = index;
                  print('current index : $_currentPageIndex');
                });
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.keyboard_backspace,
                      color: Colors.white,
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },

                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border, color: Colors.white,))
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF),
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        border: Border.all(color: Colors.white, width: 0.4),
                      ),
                      child: Center(
                        child: Text(
                          'Save foto gallery',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    onTap: () {
                      print("cuurent index :$_currentPageIndex");
                      SavePhoto().save(widget
                          .listPhoto[_currentPageIndex!].src!.portrait
                          .toString());
                      Navigator.pop(context);
                      print('Click');
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//
// Container(
// height: double.infinity,
// width: double.infinity,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage(widget.photo.src!.portrait.toString()), fit: BoxFit.cover),
// ),
// )
