import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/data/bloc/post/post_bloc.dart';
import 'package:wallpaper_hub/data/bloc/theme/theme_bloc.dart';
import 'package:wallpaper_hub/ui/pages/home_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.themeData,
            home: BlocProvider(
              create: (context) => PostBloc(),
              child: HomePage(),
            ),
          );
        },
      ),
    );
  }
}
