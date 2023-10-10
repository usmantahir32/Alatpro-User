import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/controllers/filter_controller.dart';
import 'package:services_finder/models/sort.dart';
import 'package:services_finder/utils/size_config.dart';

class SortType extends StatelessWidget {
  final filterCont = Get.find<FilterController>();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...List.generate(
            sortList.length,
            (index) => Padding(
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2),
                  child: SizedBox(
                    width: index == 0
                        ? SizeConfig.widthMultiplier * 40
                        : SizeConfig.widthMultiplier * 50,
                    child: Row(
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              filterCont.sortIndex.value = index;
                            },
                            child: CircleAvatar(
                              radius: SizeConfig.widthMultiplier * 3.5,
                              backgroundColor: Colors.grey.shade200,
                              child:filterCont.sortIndex.value == index
                                  ? CircleAvatar(
                                      radius: SizeConfig.widthMultiplier * 2,
                                      backgroundColor:
                                          ColorsConstant.kPrimaryColor)
                                  : const SizedBox(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
                        ),
                        Text(
                          sortList[index].sortType,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.6,
                              fontWeight: FontWeight.w600),
                        ).tr()
                      ],
                    ),
                  ),
                ))
      ],
    );
  }
}