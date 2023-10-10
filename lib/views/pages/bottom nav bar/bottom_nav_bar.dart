import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/constants/icons.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/drawer/drawer.dart';
import 'package:services_finder/views/pages/bottom%20nav%20bar/categories/categories.dart';
import 'package:services_finder/views/pages/bottom%20nav%20bar/favorites/favorites.dart';
import 'package:services_finder/views/pages/bottom%20nav%20bar/home/home.dart';
import 'package:services_finder/views/pages/bottom%20nav%20bar/profile/profile.dart';
import 'package:services_finder/views/widgets/show_loading.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [
     HomePage(),
    const CategoriesPage(),
    const FavoritesPage(),
    ProfilePage()
  ];
  ButtonsController cont = Get.find<ButtonsController>();
  AuthController authCont = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    generatingTokenForUser();
    checkUserDisabled();
  }

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  generatingTokenForUser() async {
    //GENERATING A TOKEN FROM FIREBASE MESSAGING
    final fcmToken = await _fcm.getToken();
    //GETTING CURRENTUSER ID
    final uid = Get.find<AuthController>().userss?.uid ?? "Null";
    print("This is the user $uid");
    await FirebaseFirestore.instance.collection("UserTokens").doc(uid).set({
      "CreatedAt": FieldValue.serverTimestamp(),
      "Token": fcmToken,
      "UID": uid
    }).then((value) {
      print("Token successfully");
    });
  }

  Future<void> checkUserDisabled() async {
    authCont.isLoading.value = true;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(authCont.userss!.uid)
        .get()
        .then((value) {
      if (value.get("Disable")) {
        authCont.isUserDisabled.value = true;
      } else {
        authCont.isUserDisabled.value = false;
      }
    }).then((value) => authCont.isLoading.value = false);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: authCont.isUserDisabled.value
            ? SizedBox(
                height: SizeConfig.heightMultiplier * 100,
                width: SizeConfig.widthMultiplier * 100,
                child: Image.asset(
                  "assets/images/3_Something Went Wrong.png",
                  fit: BoxFit.cover,
                ),
              )
            : WillPopScope(
                onWillPop: () async {
                  print("will not close");
                  if (cont.bnbSelectedIndex.value == 0) {
                    if (authCont.isDrawer.value) {
                      authCont.isDrawer.value = false;
                      return false;
                    } else {
                      return true;
                    }
                  } else if (cont.bnbSelectedIndex.value == 1) {
                    cont.bnbSelectedIndex.value = 0;
                    return false;
                  } else if (cont.bnbSelectedIndex.value == 2) {
                    cont.bnbSelectedIndex.value = 1;
                    return false;
                  } else if (cont.bnbSelectedIndex.value == 3) {
                    cont.bnbSelectedIndex.value = 2;
                    return false;
                  } else {
                    return true;
                  }
                },
                child: Stack(
                  children: [
                    Scaffold(
                      extendBody: true,
                      body: IndexedStack(
                        index: cont.bnbSelectedIndex.value,
                        children: screens,
                      ),
                      extendBodyBehindAppBar: true,
                      bottomNavigationBar: BottomAppBar(
                        child: Container(
                          height: SizeConfig.heightMultiplier * 9,
                          width: SizeConfig.widthMultiplier * 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: authCont.isDrawer.value
                                  ? null
                                  : [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 6,
                                          offset: const Offset(
                                            -5,
                                            -5,
                                          ))
                                    ]),
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier * 1.3),
                          child: Row(
                            children: [
                              ...List.generate(
                                bottomNavItems.length,
                                (index) => InkWell(
                                  onTap: () {
                                    cont.bnbSelectedIndex.value = index;
                                  },
                                  child: SizedBox(
                                    width: SizeConfig.widthMultiplier * 25,
                                    height: SizeConfig.heightMultiplier * 9,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          bottomNavItems[index]["Icon"],
                                          color: cont.bnbSelectedIndex.value ==
                                                  index
                                              ? ColorsConstant.kPrimaryColor
                                              : Colors.grey.shade300,
                                          height:
                                              SizeConfig.heightMultiplier * 3.2,
                                        ),
                                        const Spacer(),
                                        Text(
                                          bottomNavItems[index]["Name"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: cont.bnbSelectedIndex
                                                          .value ==
                                                      index
                                                  ? ColorsConstant.kPrimaryColor
                                                  : Colors.grey.shade300,
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      1.5),
                                        ).tr()
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //MAKING CUSTOM DRAWER
                    //BLUR CONTAINER
                    Positioned(
                      bottom: 0,
                      child: authCont.isDrawer.value
                          ? BlurryContainer(
                              child: const SizedBox(),
                              blur: 3,
                              width: SizeConfig.widthMultiplier * 100,
                              height: SizeConfig.heightMultiplier * 100,
                              elevation: 0,
                              color: Colors.black12,
                              padding: const EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(0),
                            )
                          : const SizedBox(),
                    ),
                    //DRAWER
                    AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        bottom: 0,
                        left: authCont.isDrawer.value
                            ? SizeConfig.widthMultiplier * 0
                            : -SizeConfig.widthMultiplier * 70,
                        child: SizedBox(
                            height: SizeConfig.heightMultiplier * 100,
                            width: SizeConfig.widthMultiplier * 70,
                            child: const AppDrawer())),
                    //DRAWER CLOSE BUTTON
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      top: SizeConfig.heightMultiplier * 8,
                      right: authCont.isDrawer.value
                          ? SizeConfig.widthMultiplier * 8
                          : -SizeConfig.widthMultiplier * 15,
                      child: GestureDetector(
                        onTap: () {
                          authCont.isDrawer.value = false;
                        },
                        child: CircleAvatar(
                          radius: SizeConfig.widthMultiplier * 5,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Map bottomNavItems = {
    0: {"Name": "Home", "Icon": IconsConstant.home},
    1: {"Name": "Categories", "Icon": IconsConstant.category},
    2: {"Name": "Favorites", "Icon": IconsConstant.favorites},
    3: {"Name": "Profile", "Icon": IconsConstant.profile}
  };
}
