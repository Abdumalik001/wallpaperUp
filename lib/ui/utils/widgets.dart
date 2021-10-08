import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub/data/models/photos_model.dart';
import 'package:wallpaper_hub/ui/pages/photo_page.dart';

Widget titleAppbarWidget(BuildContext context) {
  return Container(
    width: double.infinity,
    child: Center(
      child: Row(
        children: [
          Text(
            'Wallpaper',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            'Up',
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
    ),
  );
}

Widget photosWidget(List<Photos> list, BuildContext context,
    ScrollController controller, bool isLoadingMore) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        // physics: NeverScrollableScrollPhysics(),

        controller: controller,
        shrinkWrap: true,
        children: [
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: List.generate(list.length, (index) {
              return Stack(children: [
                GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: list[index].src!.portrait.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PhotoPage(listPhoto: list, currentIndex: index),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onTap: () {
                      print(index);

                    },
                  ),
                )
              ]);
            }),
          ),
          isLoadingMore
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(),
        ],
      ),
    ),
  );
}
