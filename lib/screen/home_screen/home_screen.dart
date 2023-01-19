
import 'package:image_editor/screen/sticker_view/sticker_view.dart';
import 'package:image_editor/utils/imports.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Sticker> stickerDataList = [];
  StickerController stickerController = Get.put(StickerController());
  ScreenshotController screenshotController = ScreenshotController();
  ScrollController scrollController = ScrollController();
  int pageCount = 1;

  @override
  void initState() {
    init(pageCount: pageCount);
    super.initState();
  }

  init({required int pageCount}) async {
    await stickerController.getStickerData(context: context, pageCount: pageCount).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: buildTextField(title: str_appName),
            actions: [
              TextButton(
                   onPressed: () {
                     stickerDataList.isNotEmpty
                         ?saveToGallery()
                         :null;
                    },
                  child: buildTextField(title: str_save, fColor: Colors.white, fSize: 15))
            ],
          ),
          body: buildBody(),
        )
    );
  }

  Widget buildBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.blue,
      child: buildBodyWidget(),
    );
  }

  Widget buildBodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///Image Widget
        Expanded(flex: 8, child: buildPhotoWidget()),

        ///Sticker Widget
        Expanded(
          flex: 2,
          child: buildStickerPicker(),
        )
      ],
    );
  }

  ///Image Widget
  Widget buildPhotoWidget() {
    return SizedBox(
      height: Get.height * 0.65,
      width: Get.width,
      child: Screenshot(
        controller: screenshotController,
        child: Stack(
          children: [
            buildImage(),
            buildStickerList(),
          ],
        ),
      ),
    );
  }

  ///Background Image
  Widget buildImage() {
    return SizedBox(
      height: Get.height * 0.65,
      width: Get.width,
      child: Image.asset('assets/images/bg_image.jpeg'),
    );
  }

  ///Sticker List
  Widget buildStickerList() {
    // return StickerView(
    //   height: Get.height * 0.65,
    //   width: Get.width,
    //   stickerList: stickerDataList,
    // );
    return StickerViewCustom(
      height: Get.height * 0.65,
      width: Get.width,
      stickerList: stickerDataList,
    );
  }

  ///Sticker Widget
  buildStickerPicker() {
    return GetBuilder<StickerController>(
      init: stickerController,
      builder: (controller) {
        if (controller.isEmpty) {
          return const EmptyScreen();
        } else if (controller.isLoading) {
          return const SpinKitSpinningLines(
            itemCount: 3,
            color: Colors.red,
            size: 70.0,
            lineWidth: 6,
          );
        } else if (controller.stickerModel?.data?.stickerData != null &&
            controller.stickerModel?.data?.stickerData?.isNotEmpty == true) {
          return ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.stickerModel?.data?.stickerData?.length,
              itemBuilder: (context, index) {
                if(index%29 == 0){
                  pageCount++;
                  init(pageCount: pageCount);
                }
                return buildSticker(controller: controller, index: index);
              });
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  ///Single Sticker View
  Widget buildSticker({required StickerController controller, required int index}) {
    return GestureDetector(
      onTap: () {
        List<int> ids = [];
        stickerDataList.forEach((element) {
          ids.add(int.parse(element.id.toString()));
        });
        if (ids
            .contains(controller.stickerModel?.data?.stickerData?[index].id)) {
        } else {
          stickerDataList.add(buildCustomSticker(
            id: controller.stickerModel?.data?.stickerData?[index].id
                    .toString() ??
                '',
            isText: false,
            url: controller.stickerModel?.data?.stickerData?[index].image
                    .toString() ??
                '',
          ));
        }
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: Get.height * 0.25,
        width: Get.height * 0.25,
        // color: Colors.yellow,
        child: buildCustomSticker(
          id: controller.stickerModel?.data?.stickerData?[index].id
                  .toString() ??
              '',
          isText: false,
          url: controller.stickerModel?.data?.stickerData?[index].image
                  .toString() ??
              '',
        ),
      ),
    );
  }


 Future<void> saveToGallery() async {

   final directory = (await getApplicationDocumentsDirectory ()).path; //from path_provide package
   String fileName = DateTime.now().microsecondsSinceEpoch.toString();
   String path = '$directory';

   screenshotController.captureAndSave(
       path, //set path where screenshot will be saved
       fileName : fileName
   ).then((value){
     Fluttertoast.showToast(msg: "Saved At => ${value.toString()}");
   });

 }

}
