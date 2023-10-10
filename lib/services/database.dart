import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/models/category_model.dart';
import 'package:services_finder/models/products_model.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class DataBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///for creating user data

  Future<bool> createUser(UserModel user) async {
    try {
      await _firestore.collection("Users").doc(user.id).set({
        "FullName": user.fullName,
        "Email": user.email,
        "Phone": user.phone,
        "Password": user.password,
        "Image":
            "https://i.pinimg.com/280x280_RS/2e/45/66/2e4566fd829bcf9eb11ccdb5f252b02f.jpg",
        "searchKey": user.fullName!.toLowerCase(),
        "Disable": false,
        "WhichLogin": user.whichLogin,
        "RentTypeIndex": 0
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //SHOWING THE PRODUCTS
  Stream<List<ProductsModel>> streamForProducts() {
    return _firestore
        .collection("Products")
        .where("Recommended", isEqualTo: true)
        .where("Disable", isEqualTo: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProductsModel> products = [];
      // ignore: avoid_function_literals_in_foreach_calls
      query.docs.forEach((element) {
        products.add(ProductsModel.fromDocumentSnapshot(element));
      });
      return products;
    });
  }

  //SHOWING THE FAVOURITE PRODUCTS
  Stream<List<ProductsModel>> streamForFavouriteProducts() {
    return _firestore
        .collection("Products")
        .where("Disable", isEqualTo: false)
        .where("LikedBy", arrayContains: Get.find<AuthController>().userss!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProductsModel> products = [];

      // ignore: avoid_function_literals_in_foreach_calls
      query.docs.forEach((element) {
        products.add(ProductsModel.fromDocumentSnapshot(element));
      });
      return products;
    });
  }

  //STREAM CATEGORIES
  Stream<List<CategoryModel>> streamForCategories() {
    return _firestore
        .collection("Categories")
        .where("Disable", isEqualTo: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<CategoryModel> category = [];
      query.docs.forEach((element) {
        print(element);
        category.add(CategoryModel.fromDocumentSnapshot(element));
      });
      return category;
    });
  }

  //ON IMAGE UPDATE
  Future<void> onImageUpdate(String imageURL) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(Get.find<AuthController>().userss!.uid)
        .update({"Image": imageURL})
        .then((va) => Get.find<AuthController>().getUser())
        .then((value) => Get.find<AuthController>().isLoading.value = false);
  }

  //CHANGE PASSWORD QUERY
  Future<void> onChangePassword(
      String oldPass, String newPass, String confirmNewPass) async {
    try {
      if (oldPass.isNotEmpty &&
          newPass.isNotEmpty &&
          confirmNewPass.isNotEmpty) {
        if (oldPass == Get.find<AuthController>().userInfo.password) {
          if (newPass == confirmNewPass) {
            Get.find<AuthController>().isLoading.value = true;
            Get.find<AuthController>()
                .userss!
                .updatePassword(newPass)
                .then((value) {
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(Get.find<AuthController>().userss!.uid)
                  .update({"Password": newPass});
            }).then((value) {
              Get.find<AuthController>().isLoading.value = false;

              Get.snackbar(
                  tr("Changed"), tr("Your password is successfully changed ;)"),
                  backgroundColor: Colors.green, colorText: Colors.white);
            });
          } else {
            Get.snackbar(tr("Please try again"),
                tr("Your new and confirm password doesn't match :("),
                backgroundColor: Colors.redAccent, colorText: Colors.white);
          }
        } else {
          Get.snackbar(
              tr("Please try again"), tr("Your old password is incorrect :("),
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      } else {
        Get.snackbar(
            tr("Please try again"), tr("Please fill all the fields :("),
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.find<AuthController>().isLoading.value = false;
      Get.snackbar(tr("Please try again"), "$e".split("]")[1],
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  //SUBMIT VENDOR FORM
  Future<void> submitForm(String name, String companyName, String position,
      String email, String phone, String city, String pdfURL) async {
    Get.find<AuthController>().isLoading.value = true;
    await _firestore.collection("Vendors").add({
      "Name": name,
      "CompanyName": companyName,
      "Email": email,
      "Phone": phone,
      "City": city,
      "PDFurl": pdfURL,
      "Date": DateTime.now().toString(),
      "Disable": false,
    }).then((value) {
      Get.find<AuthController>().isLoading.value = false;

      Get.snackbar(tr("Successfully Submitted"),
          tr("Your form is submitted please wait to proceed to us"),
          backgroundColor: Colors.green, colorText: Colors.white);
    });
  }

  //EDIT PROFILE
  Future<void> editProfile(String fullName, String phone) async {
    Get.find<AuthController>().isLoading.value = true;
    await _firestore
        .collection("Users")
        .doc(Get.find<AuthController>().userss!.uid)
        .update({
          "FullName": fullName,
          "Phone": phone,
          "searchKey": fullName.toLowerCase()
        })
        .then((value) => Get.find<AuthController>().isLoading.value = false)
        .then((value) => Get.snackbar(
            tr("Successfully Updated"), tr("Your profile details are updated"),
            backgroundColor: Colors.green, colorText: Colors.white));
  }

  //REQUEST EQUIPMENT
  Future<void> requestEquipment(
      String name, String email, String equipmentName) async {
    Get.find<AuthController>().isLoading.value = true;
    await _firestore
        .collection("RequestedEquipments")
        .add({
          "Name": name,
          "Email": email,
          "EquipmentName": equipmentName,
          "Date": DateTime.now().toString(),
          "Disable": false,
        })
        .then((value) => Get.find<AuthController>().isLoading.value = false)
        .then((value) => Get.snackbar(tr("Successfully Submitted"),
            tr("Your form is submitted please wait to proceed to us"),
            backgroundColor: Colors.green, colorText: Colors.white));
  }

  //ADD CAREER
  Future<void> addCareer(
      String name, String phone, String email, String cvURL) async {
    Get.find<AuthController>().isLoading.value = true;
    await _firestore
        .collection("Careers")
        .add({
          "Name": name,
          "Phone": phone,
          "Email": email,
          "cvURL": cvURL,
          "Date": DateTime.now().toString(),
          "Disable": false,
        })
        .then((value) => Get.find<AuthController>().isLoading.value = false)
        .then((value) => Get.snackbar(tr("Successfully Submitted"),
            tr("Your form is submitted please wait to proceed to us"),
            backgroundColor: Colors.green, colorText: Colors.white));
  }

  //ADD CONTRACTOR SERVICES
  Future<void> addContractorServices(String name, String phone, String company,
      String projectDescription, String attachment) async {
    Get.find<AuthController>().isLoading.value = true;
    await _firestore
        .collection("ContractorServices")
        .add({
          "Name": name,
          "Phone": phone,
          "Company": company,
          "ProjectDescription": projectDescription,
          "Attachment": attachment,
          "Date": DateTime.now().toString(),
          "Disable": false,
        })
        .then((value) => Get.find<AuthController>().isLoading.value = false)
        .then((value) => Get.snackbar(tr("Successfully Submitted"),
            tr("Your form is submitted please wait to proceed to us"),
            backgroundColor: Colors.green, colorText: Colors.white));
  }

  //CONTACT US
  Future<void> contactUS(
      String name, String phone, String email, String message) async {
    Get.find<AuthController>().isLoading.value = true;
    await _firestore
        .collection("ContactUs")
        .add({
          "Name": name,
          "Phone": phone,
          "Email": email,
          "Message": message,
          "Date": DateTime.now().toString(),
          "Disable": false,
        })
        .then((value) => Get.find<AuthController>().isLoading.value = false)
        .then((value) => Get.snackbar(tr("Successfully Submitted"),
            tr("Thanks for contacting us, we will soon let you know"),
            backgroundColor: Colors.green, colorText: Colors.white));
  }

  //CHANGE RENTYPE
  Future<void> changeRentType(int index) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(Get.find<AuthController>().userss!.uid)
        .update({"RentTypeIndex": index}).then((value) => Get.find<AuthController>().getUser());
  }
}
