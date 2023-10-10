import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/custom_appbar.dart';
import 'package:services_finder/views/widgets/rent_type.dart';

class ChangeRentTypePage extends StatefulWidget {
  const ChangeRentTypePage({ Key? key }) : super(key: key);

  @override
  State<ChangeRentTypePage> createState() => _ChangeRentTypePageState();
}

class _ChangeRentTypePageState extends State<ChangeRentTypePage> {
  final buttonCont = Get.find<ButtonsController>();
  @override
  void dispose() {
    super.dispose();
    DataBase().changeRentType(buttonCont.selectedRentType.value);
  }
  @override
  void initState() {
    super.initState();
    buttonCont.selectedRentType.value=Get.find<AuthController>().userInfo.rentTypeIndex??0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Rent Type'),
      body: Padding(
        padding:  EdgeInsets.only(left: SizeConfig.widthMultiplier*5,right: SizeConfig.widthMultiplier*20),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            RentType()
          ],
        ),
      ),
    );
  }
}