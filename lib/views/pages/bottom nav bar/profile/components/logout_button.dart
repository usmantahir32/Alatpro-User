import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/utils/size_config.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.heightMultiplier * 5.5,
        width: SizeConfig.widthMultiplier * 90,
        margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: Text(
            "Logout",
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2,
                fontWeight: FontWeight.w600),
          ).tr(),
        ),
      ),
    );
  }
}
