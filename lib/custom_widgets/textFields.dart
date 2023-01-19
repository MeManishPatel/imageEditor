import 'package:image_editor/utils/imports.dart';

Widget buildTextField({required String title, Color? fColor, double? fSize}) {
  return Text(
    title,
    style: TextStyle(
      color: fColor ?? Colors.black,
      fontSize: fSize ?? 14,
    ),
  );
}