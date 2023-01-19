import 'package:image_editor/utils/imports.dart';

class ConnectionValidator{
  Future<bool> check() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.mobile){
      return true;
    }else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}