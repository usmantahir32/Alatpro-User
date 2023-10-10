import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/constants/icons.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/filter/filter.dart';
import 'package:services_finder/views/pages/search/search.dart';

class HomeUpperContainer extends GetWidget<AuthController> {
  const HomeUpperContainer(  {
    Key? key,
    required this.onChange,
    required this.cont
  }) : super(key: key);
  final Function(String)? onChange;
  final TextEditingController cont;
  @override
  Widget build(BuildContext context) {
    final buttonCont = Get.find<ButtonsController>();
    return Container(
      height: SizeConfig.heightMultiplier * 25,
      width: SizeConfig.widthMultiplier * 100,
      color: ColorsConstant.kPrimaryColor,
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.heightMultiplier * 7,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greetingMessage(),
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 1.6,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ).tr(),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.6,
                  ),
                  Obx(
                    () => SizedBox(
                      width: SizeConfig.widthMultiplier * 70,
                      child: Text(
                        controller.userInfo.fullName ?? "Loading...",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Get.find<AuthController>().isDrawer.value = true;
                },
                child: Image.asset(
                  IconsConstant.menu,
                  height: SizeConfig.heightMultiplier * 5.5,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 4,
          ),
          //SEARCH TEXTFIELD AND FILTER BUTTON
          Obx(
            () => Row(
              children: [
                InkWell(
                  // onTap: () =>Get.to(()=>const SearchPage(),transition: Transition.leftToRight),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: SizeConfig.heightMultiplier * 6,
                    width: !buttonCont.isSearch.value
                        ? SizeConfig.widthMultiplier * 90
                        : SizeConfig.widthMultiplier * 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4),
                    child: TextField(
                      controller: cont,
                      textAlignVertical: TextAlignVertical.center,
                      // style: TextStyle(fontSize: SizeConfig.textMultiplier*1.3),
                      scrollPadding: const EdgeInsets.all(0),
                      onChanged: onChange,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(0),
                        hintText: tr("Search"),
                        suffixIcon: Icon(
                          FeatherIcons.search,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                        hintStyle: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),

                      
                    ),
                  ),
                ),
                const Spacer(),
                buttonCont.isSearch.value
                     
                    ? InkWell(
                        onTap: () {
                          Get.to(() => const FilterPage(),
                              transition: Transition.leftToRight);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 2),
                          child: Image.asset(
                            IconsConstant.filter,
                            height: SizeConfig.heightMultiplier * 3.7,
                          ),
                        ),
                      ):const SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
  String greetingMessage(){

  var timeNow = DateTime.now().hour;
  
  if (timeNow <= 12) {
    return 'Good Morning';
  } else if ((timeNow > 12) && (timeNow <= 16)) {
  return 'Good Afternoon';
  } else if ((timeNow > 16) && (timeNow < 20)) {
  return 'Good Evening';
  } else {
  return 'Good Night';
  }
}
}
