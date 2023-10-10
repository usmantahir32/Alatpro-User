import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/change%20rent%20type/change_rent_type.dart';
import 'package:services_finder/views/widgets/custom_appbar.dart';
import 'package:services_finder/views/widgets/row_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Settings'),
      body: Column(
        children: [
          SizedBox(
            height: SizeConfig.heightMultiplier * 2,
          ),
          RowButton(
            text: "Rent Type",
            onTap: () => Get.to(() => ChangeRentTypePage(),
                transition: Transition.leftToRight),
            isDivider: false,
          )
        ],
      ),
    );
  }
}
