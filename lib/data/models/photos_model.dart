



import 'package:wallpaper_hub/data/models/src_model.dart';

class Photos {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  Src? src;
  bool? liked;

  Photos(
      {this.id,
        this.width,
        this.height,
        this.url,
        this.photographer,
        this.photographerUrl,
        this.photographerId,
        this.avgColor,
        this.src,
        this.liked});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    src = json['src'] != null ? new Src.fromJson(json['src']) : null;
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['photographer'] = this.photographer;
    data['photographer_url'] = this.photographerUrl;
    data['photographer_id'] = this.photographerId;
    data['avg_color'] = this.avgColor;
    if (this.src != null) {
      data['src'] = this.src!.toJson();
    }
    data['liked'] = this.liked;
    return data;
  }
}