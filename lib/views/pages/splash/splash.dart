import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/constants/icons.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/controllers/filter_controller.dart';
import 'package:services_finder/utils/root.dart';
import 'package:services_finder/views/pages/auth%20flow/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero,()=>gettingRoot());
  }

  gettingRoot() async {
    Get.put(ButtonsController());
    Get.put(FilterController());
     Get.updateLocale(const Locale("en"));
                  context.locale = const Locale("en", "US");
 Timer(const Duration(seconds: 3),
        () => Get.off(() => const Root(), transition: Transition.leftToRight));}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.splashColor,
      
      body: Center(
        child: Image.asset(IconsConstant.appIcon),
      ),
    );
  }
}
