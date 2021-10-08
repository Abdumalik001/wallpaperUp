

import 'dart:async';

import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:wallpaper_hub/data/models/favorite_image_model.dart';

import 'dao/f_m_dao.dart';
part 'database.g.dart';
@Database(version: 1, entities: [FavoriteImageModel])
abstract class AppDatabase extends FloorDatabase{

  FavoriteDao get dao;

}