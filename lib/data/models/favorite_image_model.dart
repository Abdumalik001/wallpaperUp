import 'package:floor/floor.dart';

@entity
class FavoriteImageModel {
  @primaryKey
  final int id;
  final String imgUrl;

  FavoriteImageModel(this.id, this.imgUrl);
}
