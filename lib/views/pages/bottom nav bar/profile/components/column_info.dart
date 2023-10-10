import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/utils/size_config.dart';

class ProfileColumnInfo extends StatelessWidget {
  const ProfileColumnInfo({
    Key? key,
    required this.heading,
    required this.subtext,
  }) : super(key: key);
  final String heading, subtext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2,
                fontWeight: FontWeight.w600,
                color: ColorsConstant.kPrimaryColor),
          ).tr(),
          SizedBox(
            height: SizeConfig.heightMultiplier * 0.5,
          ),
          Text(
            subtext,
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(
            height: SizeConfig.heightMultiplier * 4,
            thickness: 0.6,
          )
        ],
      ),
    );
  }
}

