import 'package:flutter/material.dart';
import 'package:wallpaper_hub/ui/pages/favorite_page.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(

        children: [
          Container(
            padding: EdgeInsets.only(right: 20, bottom: 10),
            height: 150,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Wallpaper',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 30),
                ),
                Text(
                  'Up',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 35),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text('Favorite'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritePage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
