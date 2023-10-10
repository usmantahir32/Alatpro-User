
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/utils/size_config.dart';

class RowInfo extends StatelessWidget {
  const RowInfo({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 1.9,
              fontWeight: FontWeight.w600,
            ),
          ).tr(),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 1.9,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
