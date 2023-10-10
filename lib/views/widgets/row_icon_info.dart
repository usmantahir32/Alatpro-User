import 'package:flutter/material.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/models/categories.dart';
import 'package:services_finder/utils/size_config.dart';

class RowIconInfo extends StatelessWidget {
  const RowIconInfo({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorsConstant.kPrimaryColor,
          size: 19,
        ),
        SizedBox(
          width: SizeConfig.widthMultiplier * 2,
        ),
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              fontSize: SizeConfig.textMultiplier * 1.6),
        )
      ],
    );
  }
}
