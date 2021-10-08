import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class SavePhoto {
  void save(String url) async {
    var status = await Permission.storage.request();
    Random random = new Random();

    if (status.isGranted) {
      var response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: 'photo' + random.nextInt(100).toString(),
      );
      print(result);
      _toastInfo('Photo saved gallery');
    }
  }

  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    // _toastInfo(info);
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }
}
