import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/career/career.dart';
import 'package:services_finder/views/pages/contact%20us/contact_us.dart';
import 'package:services_finder/views/pages/contractor%20service/contracter_service.dart';
import 'package:services_finder/views/pages/faqs/faqs.dart';
import 'package:services_finder/views/pages/request%20equipment/request_equipment.dart';
import 'package:services_finder/views/pages/settings/settings.dart';
import 'package:services_finder/views/pages/vendor%20form/vendor_form.dart';
import 'package:easy_localization/easy_localization.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCont = Get.find<AuthController>();
    return Drawer(
      child: Column(
        children: [
          //UPPER CONTAINER PICTUREW AND NAME
          Container(
            height: SizeConfig.heightMultiplier * 25,
            width: SizeConfig.widthMultiplier * 100,
            color: ColorsConstant.kPrimaryColor.withOpacity(0.2),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 5),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 14,
                ),
                Obx(
                  () => Row(
                    children: [
                      CircleAvatar(
                          radius: SizeConfig.widthMultiplier * 9,
                          backgroundColor:
                              ColorsConstant.kPrimaryColor.withOpacity(0.4),
                          backgroundImage:
                              NetworkImage(authCont.userInfo.image ?? "")),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 4,
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 35,
                        child: Text(
                          authCont.userInfo.fullName ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.textMultiplier * 2.3),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          ///DRAWER OPTIONS
          DrawerOptions(
            text: "Request Equipment",
            icon: Icons.construction,
            onTap: () => Get.to(() => RequestEquipmentPage(),
                transition: Transition.leftToRight),
          ),
          DrawerOptions(
            text: "Settings",
            icon: FeatherIcons.settings,
            onTap: () => Get.to(() => SettingsPage(),
                transition: Transition.leftToRight),
          ),
          DrawerOptions(
            text: "Vendor",
            icon: Icons.assignment_ind_outlined,
            onTap: () => Get.to(() => VendorFormPage(),
                transition: Transition.leftToRight),
          ),
          DrawerOptions(
            text: "Career",
            icon: Icons.card_travel_sharp,
            onTap: () =>
                Get.to(() => CareerPage(), transition: Transition.leftToRight),
          ),
          DrawerOptions(
            text: "FAQ",
            icon: Icons.help_outline,
            onTap: () =>Get.to(() => const FaqsPage(),
                transition: Transition.leftToRight),
          ),
          DrawerOptions(
            text: "Contractor Services",
            icon: Icons.man_rounded,
            onTap: () => Get.to(() => ContractorService(),
                transition: Transition.leftToRight),
          ),
          DrawerOptions(
            text: "Contact us",
            icon: Icons.call,
            onTap: () => Get.to(() => ContactUsPage(),
                transition: Transition.leftToRight),
          )
        ],
      ),
    );
  }
}

class DrawerOptions extends StatelessWidget {
  const DrawerOptions({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.widthMultiplier * 5,
          top: SizeConfig.heightMultiplier * 4),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: SizeConfig.widthMultiplier * 4,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.textMultiplier * 1.7),
            ).tr()
          ],
        ),
      ),
    );
  }
}
