import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/loading.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'discount_card.dart';

class HomeAdsWidget extends StatelessWidget {
  const HomeAdsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cont = Get.find<ButtonsController>();
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("ads").snapshots(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? SizedBox(
                  height: SizeConfig.heightMultiplier * 18,
                  width: SizeConfig.widthMultiplier * 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorsConstant.kPrimaryColor,
                    ),
                  ),
                )
              : Column(children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  CarouselSlider(
                      items: [
                        for (int i = 0;
                            i < snapshot.data!.docs.length;
                            i++) ...[
                          Container(
                            height: SizeConfig.heightMultiplier * 15,
                            width: SizeConfig.widthMultiplier * 90,
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data!.docs[i].get("Image")),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xFFfff6e5)),
                          )
                        ]
                      ],
                      options: CarouselOptions(
                        height: SizeConfig.heightMultiplier * 13,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.97,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        enlargeCenterPage: false,
                        onPageChanged: (int pageNumber, reason) {
                          cont.adsIndex.value = pageNumber;
                        },
                        scrollDirection: Axis.horizontal,
                      )),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  Obx(
                    () => AnimatedSmoothIndicator(
                      activeIndex: cont.adsIndex.value,
                      count: snapshot.data!.docs.length,
                      effect: SlideEffect(
                          spacing: 8.0,
                          radius: 7,
                          dotWidth: 8,
                          dotHeight: 8,
                          paintStyle: PaintingStyle.fill,
                          strokeWidth: 1.5,
                          dotColor: Colors.grey.shade300,
                          activeDotColor: Colors.grey.shade700),
                    ),
                  ),
                ]);
        });
  }
}
