import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/utils/size_config.dart';

class YearPicker extends StatelessWidget {
  const YearPicker({
    Key? key,
    required this.heading,
    required this.subheading,
    required this.onCalendarTap,
  }) : super(key: key);
  final String heading, subheading;
  final VoidCallback onCalendarTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 6,
      width: SizeConfig.widthMultiplier * 43,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 0.5,
          horizontal: SizeConfig.widthMultiplier * 2),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.7,
                    fontWeight: FontWeight.w700),
              ).tr(),
              const Spacer(),
              Text(
                subheading,
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.8,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: onCalendarTap,
            child: Icon(
              Icons.calendar_month_sharp,
              color: ColorsConstant.kPrimaryColor,
            ),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 1,
          )
        ],
      ),
    );
  }
}
