import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_hub/data/models/photos_model.dart';
import 'package:wallpaper_hub/data/models/post_model.dart';
import 'package:wallpaper_hub/ui/utils/utils.dart';


const _baseUrl = 'https://api.pexels.com/v1/';
const  headers={
  "Authorization":apikey
};

class NetworkService {
  final http.Client client = http.Client();
  bool hasNextPage = true;

  Future<List<Photos>?> getCuratedPosts(int page) async {
  //  List<Photos> photos = [];

    print('servise page $page');
    var response = await http.get(
      Uri.parse('${_baseUrl}curated/?page=$page&per_page=80'),
      headers:headers,
    );
    try {
      PostModel postModel = new PostModel();
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        postModel = PostModel.fromJson(jsonData);
        return postModel.photos;
      }
    } catch (e) {
      print(e.toString());
    }

  }

  Future<bool> getHasNextPage() async{
    return hasNextPage;
  }

  Future<List<Photos>> getSearchList(String searchText, int page) async {
 //   List<Photos> searchPhotos = [];
    PostModel postModel = PostModel();
    Response? response;

    try {
      var response = await http.get(
        Uri.parse(
            '${_baseUrl}search/?page=$page&query=${searchText}&per_page=80'),
        headers:headers,
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        postModel = PostModel.fromJson(jsonData);
        return postModel.photos!;
      }
    } catch (e) {
      print('${e.toString()}  ${response!.statusCode}');
    }

    return [];
  }
}
