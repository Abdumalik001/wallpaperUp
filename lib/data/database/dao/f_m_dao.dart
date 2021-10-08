import 'package:floor/floor.dart';
import 'package:wallpaper_hub/data/models/favorite_image_model.dart';

@dao
abstract class FavoriteDao {
  @Query('Select * from FavoriteImageModel')
  Future<List<FavoriteImageModel>> getAllImages();

  @Query('SELECT * FROM Person WHERE id = :id')
  Stream<FavoriteImageModel?> findImageById(int id);

  @insert
  Future<void> insertImage(FavoriteImageModel imageModel);

  @delete
  Future<void> deleteImage(FavoriteImageModel imageModel);
}
