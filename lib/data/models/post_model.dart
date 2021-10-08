



import 'package:wallpaper_hub/data/models/photos_model.dart';

class PostModel {
  int? totalResults;
  int? page;
  int? perPage;
  List<Photos>? photos;
  String? nextPage;

  PostModel(
      {this.totalResults, this.page, this.perPage, this.photos, this.nextPage});

  PostModel.fromJson(Map<String, dynamic> json) {
    totalResults = json['total_results'];
    page = json['page'];
    perPage = json['per_page'];
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_results'] = this.totalResults;
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['next_page'] = this.nextPage;
    return data;
  }
}