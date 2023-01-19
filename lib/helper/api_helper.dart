import 'package:dio/dio.dart';
import 'package:image_editor/helper/connection_validator.dart';
import 'package:image_editor/model/sticker_response_model.dart';

class ApiHelper {
  final Dio _dio = Dio();

  Future<StickerResponseModel?> getStickerDataApi(
      {context, required String url}) async {
    StickerResponseModel? result;
    if (await ConnectionValidator().check()) {
      try {
        final Response? response =
            await requestGetForApi(context: context, url: url);
        if (response?.data != null && response?.statusCode == 200) {
          result = StickerResponseModel.fromJson(response?.data);
        }
        return result;
      } catch (e) {
        print("Exception_main1: $e");
        return result;
      }
    } else {}
    return null;
  }

  Future<Response?> requestGetForApi({required context, String? url}) async {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=5, max=1000",
      };

      BaseOptions options = BaseOptions(
          receiveTimeout: 60 * 1000,
          connectTimeout: 60 * 1000,
          headers: headers,
          validateStatus: (_) => true);

      _dio.options = options;
      Response response = await _dio.get(url!);
      print("Response_headers: ${response.headers}");
      print("Response_data: ${response.data}");

      return response;
    } catch (error) {
      print("Exception_Main: $error");
      return null;
    }
  }
}
