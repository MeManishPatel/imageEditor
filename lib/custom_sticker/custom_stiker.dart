import 'package:image_editor/utils/imports.dart';

Sticker buildCustomSticker({required String id, required bool isText, required String url}){
  return Sticker(
    id: id,
    isText: true,
    child: isText
        ? const Text("Hello")
        : Image.network(url),
  );
}