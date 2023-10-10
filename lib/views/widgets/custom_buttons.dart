import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/utils/size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.heightMultiplier * 7,
        width: SizeConfig.widthMultiplier * 90,
        decoration: BoxDecoration(
            color: ColorsConstant.kPrimaryColor,
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig.textMultiplier * 2,
                color: Colors.white),
          ).tr(),
        ),
      ),
    );
  }
}
