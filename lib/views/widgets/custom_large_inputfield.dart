import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/utils/size_config.dart';

class CustomLargeInputField extends StatelessWidget {
  const CustomLargeInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText, label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 16,
      width: SizeConfig.widthMultiplier * 90,
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.widthMultiplier * 3,
      ),
      decoration: BoxDecoration(
          color: ColorsConstant.textfieldColor,
          borderRadius: BorderRadius.circular(6)),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier *4,
              ),
              TextField(
                obscureText: label == "Password" ? true : false,
                controller: controller,
                maxLines: 4,
                scrollPadding: const EdgeInsets.all(0),
                style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.9),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintMaxLines: 2,
                    hintText: hintText.tr(),
                    hintStyle:
                        TextStyle(fontSize: SizeConfig.textMultiplier * 1.9),
                    contentPadding: const EdgeInsets.all(0)),
              ),
            ],
          ),
          Positioned(
            top: SizeConfig.heightMultiplier * 0.8,
            left: 0,
            child: Text(
              label,
              style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 1.8,
                  fontWeight: FontWeight.w700),
            ).tr(),
          ),
        ],
      ),
    );
  }
}
