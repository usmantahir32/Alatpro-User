import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemImages extends StatelessWidget {
  const ItemImages({
    Key? key,
    required this.images,
    required this.buttonCont,
  }) : super(key: key);

  final List images;
  final ButtonsController buttonCont;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.heightMultiplier * 30,
      width: SizeConfig.widthMultiplier * 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
              itemCount: images.length,
              onPageChanged: (val) {
                print(val);
                buttonCont.itemImageIndex.value = val;
              },
              itemBuilder: (_, i) => InkWell(
                onTap: (){
                  showImageViewer(
                                  context,
                                  Image.network(images[i] ??
                                          "")
                                      .image,
                                  swipeDismissible: true);
                },
                child: SizedBox(
                      height: SizeConfig.heightMultiplier * 30,
                      width: SizeConfig.widthMultiplier * 100,
                      child: Image.network(
                        images[i],
                        fit: BoxFit.cover,
                      ),
                    ),
              )),
          Positioned(
              top: SizeConfig.heightMultiplier * 2,
              left: SizeConfig.widthMultiplier * 4,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: SizeConfig.heightMultiplier * 4,
                  width: SizeConfig.widthMultiplier * 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.black.withOpacity(0.6)),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              )),
          Positioned(
              bottom: SizeConfig.heightMultiplier * 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 1,
                    vertical: SizeConfig.heightMultiplier * 0.1),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10)),
                child: Obx(
                  () => AnimatedSmoothIndicator(
                    activeIndex: buttonCont.itemImageIndex.value,
                    count: images.length,
                    effect: WormEffect(
                        spacing: 8.0,
                        radius: 7,
                        dotWidth: 8,
                        dotHeight: 8,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1.5,
                        dotColor: Colors.white.withOpacity(0.6),
                        activeDotColor: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
