import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/utils/size_config.dart';


class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier * 3,
              top: SizeConfig.heightMultiplier * 1,
              bottom: SizeConfig.heightMultiplier * 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Change Password",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        fontWeight: FontWeight.w600,
                        color: ColorsConstant.kPrimaryColor),
                  ).tr(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              Divider(
                height: SizeConfig.heightMultiplier * 4,
                thickness: 0.6,
              )
            ],
          ),
        ),
      ),
    );
  }
}