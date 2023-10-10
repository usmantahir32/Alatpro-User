import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/change%20password/change_password.dart';
import 'components/appbar.dart';
import 'components/change_password_button.dart';
import 'components/column_info.dart';
import 'components/logout_button.dart';
import 'components/user_photo.dart';

class ProfilePage extends StatelessWidget {
  final authCont = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: -Get.height * 0.75,
          left: -SizeConfig.widthMultiplier * 60,
          right: -SizeConfig.widthMultiplier * 60,
          child: Container(
            height: SizeConfig.heightMultiplier * 100,
            width: SizeConfig.widthMultiplier * 200,
            decoration: BoxDecoration(
                color: ColorsConstant.kPrimaryColor, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: 0,
          left: SizeConfig.widthMultiplier * 2,
          right: SizeConfig.widthMultiplier * 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 6,
              ),
              //APPBAR
              const ProfileAppbar(),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              //USER PHOTO
              UserPhoto(),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              //USER NAME
              Center(
                child: Obx(
                  () => Text(
                    authCont.userInfo.fullName ?? "",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.4,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              //USER INFO
              Obx(
                () => ProfileColumnInfo(
                  heading: "Phone",
                  subtext: authCont.userInfo.phone ?? "",
                ),
              ),
              Obx(
                () => ProfileColumnInfo(
                  heading: "Email address",
                  subtext: authCont.userInfo.email ?? "",
                ),
              ),
              ChangePasswordButton(
                onTap: () {
                  if (authCont.userInfo.whichLogin == "Email") {
                    Get.to(() => ChangePasswordPage(),
                        transition: Transition.rightToLeft);
                  } else {
                    Get.snackbar("Social User Found",
                        "Any social user cannot change a password in Alatpro",
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white);
                  }
                },
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 12,
              ),
              LogoutButton(
                onTap: () {
                  authCont.onSignOut();
                },
              ),
            ],
          ),
        )
      ],
    ));
  }
}
