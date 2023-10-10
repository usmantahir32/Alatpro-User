import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/category_controller.dart';
import 'package:services_finder/controllers/products_controller.dart';
import 'package:services_finder/controllers/search_controller.dart';
import 'package:services_finder/models/user_model.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/utils/root.dart';

import 'buttons_controller.dart';
import 'filter_controller.dart';

class AuthController extends GetxController {
  //FIREBASE METHODS
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  RxBool isLoading = false.obs;
  RxBool isDrawer = false.obs;
  RxBool isUserDisabled=false.obs;

  //Here we take FirebaseUser as observable
  final Rxn<User> _firebaseUser = Rxn<User>();

  //Here we use getter for making the user data email to call anywhere in the app
  String? get user => _firebaseUser.value?.email;

  //Here we take User Model as observable for showing the user data in the app
  Rx<UserModel> userModel = UserModel().obs;

  //Here we get and set the usermodel data for using anywhere in the app
  UserModel get userInfo => userModel.value;
  set userInfo(UserModel value) => userModel.value = value;

  //Here we are getting the userData
  User? get userss => _firebaseUser.value;

  @override
  // ignore: type_annotate_public_apis
  onInit() {
    //Here we bind the stream which is used getting the data in the stream which have more then one type of data it is only used on observable list only
    _firebaseUser.bindStream(_auth.authStateChanges());
    // initGoogleAuth();

    super.onInit();
  }

  getUser() async {
    try {
      print("printing");
      //It is getting data from the collection of "Users" which is in the database(uid is the unique id of each user in the app)
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userss!.uid)
          .get();
      userInfo = UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> onSignup(
      String fullName, String email, String phone, String password) async {
    try {
      final UserCredential _authResult = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //creating user in the database
      //UserModel is the model where the data of the user goes and then we show the user data from the model class by the user controller in the app
      final UserModel _user = UserModel(
          id: _authResult.user?.uid,
          fullName: fullName,
          email: email,
          phone: phone,
          whichLogin: "Email",
          password: password);

      // if a user is successfully created then it goes to the homepage
      if (await DataBase().createUser(_user)) {
        Get.put(AuthController(), permanent: true);

        isLoading.value = false;
        Get.offAll(() => const Root(), transition: Transition.leftToRight);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(tr("Please try again"), "$e".split("]")[1].trim(),
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  onSignOut() async {
    try {
      if (userInfo.whichLogin == "Google") {
        await googleSignIn.signOut();
      }
      if (userInfo.whichLogin == "Facebook") {
        await FacebookAuth.i.logOut();
      }
      await _auth
          .signOut()
          .then((value) => Get.deleteAll())
          .then((value) => Get.offAll(() => const Root()));
    } catch (e) {
      Get.snackbar("Error", "$e".split("]")[1].trim(),
          colorText: Colors.white, backgroundColor: Colors.redAccent);
    }
  }

  Future<void> checkUserBlockedOrNot(String email, String password) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .where("Email", isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        // isLoading.value = false;
        onSignIn(email, password);
      } else {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(value.docs[0].id)
            .get()
            .then((userVal) {
          if (userVal.get("Disable") == true) {
            isLoading.value = false;
            Get.snackbar(
                tr("Please try again"), tr("You are blocked on Alatpro"),
                backgroundColor: Colors.redAccent, colorText: Colors.white);
          } else {
            // isLoading.value = false;
            onSignIn(email, password);
          }
        });
      }
    });
  }

  onSignIn(String email, String password) async {
    try {
      //if the sign in done successfully then it will go to the homepage otherwise it shows error
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            Get.put(AuthController());
            getUser();
          })
          .then((value) => isLoading.value = false)
          .then((value) =>
              Get.offAll(const Root(), transition: Transition.leftToRight));
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      Get.snackbar(tr("Please try again"), "$e".split("]")[1].trim(),
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  onForgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) =>
          Get.snackbar(tr("Reset Email Send Successfully"),
              tr("Please check your email for reset password"),
              backgroundColor: Colors.green, colorText: Colors.white));
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(tr("Please try again"), "$e".split("]")[1].trim(),
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  Rxn<GoogleSignInAccount> currentUser = Rxn<GoogleSignInAccount>();

 

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      // initGoogleAuth();
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _auth
          .signInWithCredential(credential)
          .then((value) {
            final UserModel _user = UserModel(
                id: value.user!.uid,
                fullName: value.user!.displayName,
                email: value.user!.email,
                whichLogin: "Google",
                phone: tr(
                    "You signed up using Google. Please fill in your phone number using the 'Edit' button in the upper right corner"),
                password: tr("Sign in with Google Not allow to show password"));
            DataBase().createUser(_user);
          })
          .then((value) {
            Get.put(ButtonsController());
            Get.put(AuthController(), permanent: true);
            Get.put(ProductsController());
            Get.put(FilterController());
            Get.put(CategoryController());
            Get.put(SearchController());
          })
          .then((value) => getUser())
          .then((value) => isLoading.value = false);
    } catch (e) {
      isLoading.value = false;
      print("Google  Error$e");
    }
  }

  //FACEBOOK LOGIN
  onFacebookSignin() async {
    isLoading.value = true;
    final result =
        await FacebookAuth.i.login(permissions: ["public_profile", "email"]);
    if (result.status == LoginStatus.success) {
      //LOGIN QUERY
      final credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      await _auth
          .signInWithCredential(credential)
          .then((value) {
            final UserModel _user = UserModel(
                id: value.user!.uid,
                fullName: value.user!.displayName,
                email: value.user!.email,
                phone: tr(
                    "You signed up using Facebook. Please fill in your phone number using the 'Edit' button in the upper right corner"),
                whichLogin: "Facebook",
                image: value.user!.photoURL,
                password:
                    tr("Sign in with Facebook Not allow to show password"));
            DataBase().createUser(_user);
            // Get.put(() => AuthController());
          })
          .then((value) {
            Get.put(ButtonsController());
            Get.put(AuthController(), permanent: true);
            Get.put(ProductsController());
            Get.put(FilterController());
            Get.put(CategoryController());
            Get.put(SearchController());
          })
          .then((value) => getUser())
          .then((value) => isLoading.value = false);
    } else {
      isLoading.value = false;
      print("No Facebook");
    }
  }
}
