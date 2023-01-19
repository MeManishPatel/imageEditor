import 'package:flutter/rendering.dart';
import 'package:sticker_view/draggable_stickers.dart';
import 'dart:ui' as ui;
import '../../utils/imports.dart';

class StickerViewCustom extends StatefulWidget {
  final List<Sticker> stickerList;
  final double height;
  final double width;

  const StickerViewCustom({super.key, required this.stickerList, required this.height, required this.width});

  static Future<Uint8List?> saveAsUint8List(ImageQuality imageQuality) async {
    try {
      Uint8List? pngBytes;
      double pixelRatio = 1;
      if (imageQuality == ImageQuality.high) {
        pixelRatio = 2;
      } else if (imageQuality == ImageQuality.low) {
        pixelRatio = 0.5;
      }
      // delayed by few seconds because it takes some time to update the state by RenderRepaintBoundary
      await Future.delayed(const Duration(milliseconds: 700))
          .then((value) async {
        RenderRepaintBoundary boundary = stickGlobalKey.currentContext
            ?.findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        pngBytes = byteData?.buffer.asUint8List();
      });
      // returns Uint8List
      return pngBytes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  State<StickerViewCustom> createState() => _StickerViewCustomState();
}

//GlobalKey is defined for capturing screenshot
final GlobalKey stickGlobalKey = GlobalKey();

class _StickerViewCustomState extends State<StickerViewCustom> {
  List<Sticker>? stickerList;

  @override
  void initState() {
    setState(() {
      stickerList = widget.stickerList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return stickerList != null
        ? Column(children: [
        RepaintBoundary(
          key: stickGlobalKey,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            height:
            widget.height ?? MediaQuery.of(context).size.height * 0.7,
            width: widget.width ?? MediaQuery.of(context).size.width,
            child:
            //DraggableStickers class in which stickerList is passed
            DraggableStickers(
              stickerList: stickerList,
            ),
          ),
        ),
      ],)
        : const CircularProgressIndicator();
  }
}
