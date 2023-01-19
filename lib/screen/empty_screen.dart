
import 'package:image_editor/utils/imports.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Center(
        child: buildTextField(title: str_emptyData, fSize: 20, fColor: Colors.red),
      ),
    );
  }
}
