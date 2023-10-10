import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/edit%20profile/edit_profile.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Get.find<ButtonsController>().bnbSelectedIndex.value=2;
              
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.grey.shade200,
            )),
        Text(
          "Profile",
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2.3,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade100),
        ).tr(),
        GestureDetector(
          onTap: ()=>Get.to(()=>EditProfile(),transition:Transition.leftToRight),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.white),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 0.3),
            child: Text(
              "Edit",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.textMultiplier * 1.8),
            ),
          ),
        )
      ],
    );
  }
}