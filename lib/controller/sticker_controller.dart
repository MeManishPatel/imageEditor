import '../utils/imports.dart';

class StickerController extends GetxController {
  ApiHelper apiHelper = ApiHelper();
  StickerResponseModel? stickerModel;

  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;
  bool isNetworkError = false;
  bool isSuccess = false;

  Future<StickerResponseModel?> getStickerData(
      {required BuildContext context, required int pageCount}) async {
    changeEmptyValue(false);
    changeLoadingValue(true);
    changeNetworkValue(false);
    changeErrorValue(false);
    changeSuccessValue(false);

    String url = WebApiConstant.STICKERAPIURL;

    await apiHelper
        .getStickerDataApi(context: context, url: url)
        .then((result) async {
      try {
        if (result?.status == 200) {
          result != null &&
                  result.data != null &&
                  result.data!.stickerData != null &&
                  result.data!.stickerData!.isNotEmpty == true
              ? stickerModel = result
              : changeEmptyValue(true);

          changeLoadingValue(false);
          changeSuccessValue(true);
        } else if (result?.status != 200) {
          changeSuccessValue(false);
          changeLoadingValue(false);
          changeErrorValue(true);
        } else {
          changeLoadingValue(false);
          changeSuccessValue(false);
          print(result?.data);
        }
      } catch (_) {
        changeSuccessValue(false);
        changeLoadingValue(false);
        changeErrorValue(true);
        print("Exception : $_");
      }
    });
    update();
  }

  void changeSuccessValue(bool value) {
    isSuccess = value;
    update();
  }

  void changeLoadingValue(bool value) {
    isLoading = value;
    update();
  }

  void changeEmptyValue(bool value) {
    isEmpty = value;
    update();
  }

  void changeNetworkValue(bool value) {
    isNetworkError = value;
    update();
  }

  void changeErrorValue(bool value) {
    isError = value;
    update();
  }
}
