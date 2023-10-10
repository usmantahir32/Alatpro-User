import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/models/rent.dart';
import 'package:services_finder/utils/size_config.dart';

class RentType extends StatelessWidget {
  final buttonCont = Get.find<ButtonsController>();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...List.generate(
            rentList.length,
            (index) => Padding(
                  padding:
                      EdgeInsets.only(bottom:index==0 ||index ==1? SizeConfig.heightMultiplier * 2:0),
                  child: SizedBox(
                    width: index == 0
                        ? SizeConfig.widthMultiplier * 40
                        : SizeConfig.widthMultiplier * 50,
                    child: Row(
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              buttonCont.selectedRentType.value = index;
                            },
                            child: CircleAvatar(
                              radius: SizeConfig.widthMultiplier * 3.3,
                              backgroundColor: Colors.grey.shade200,
                              child: buttonCont.selectedRentType.value == index
                                  ? CircleAvatar(
                                      radius: SizeConfig.widthMultiplier * 1.8,
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
                          rentList[index].rentType,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.7,
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
