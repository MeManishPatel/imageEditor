
import 'package:image_editor/utils/imports.dart';

class ImageGallerySaver {
  static const MethodChannel _channel = MethodChannel('image_gallery_saver');

  static Future<dynamic> saveImage({required Uint8List imageBytes, int quality = 80, required String name, bool isReturnImagePathOfIOS = false}) async {
    final result = await _channel.invokeMethod('saveImageToGallery', <String, dynamic>{
      'imageBytes': imageBytes,
      'quality': quality,
      'name': name,
      'isReturnImagePathOfIOS': isReturnImagePathOfIOS
    });
    return result;
  }

}
