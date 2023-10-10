import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/utils/size_config.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,required this.height, this.text="No Data Found!",
  }) : super(key: key);
final double height;
final String? text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: SizeConfig.widthMultiplier*100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/no_data.png",
              height: SizeConfig.heightMultiplier * 20,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            Text(
              text!,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.textMultiplier * 2),
            ).tr()
          ],
        ),
    );
  }
}
