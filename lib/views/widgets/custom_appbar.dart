import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/utils/size_config.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key,required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
final String title;
  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsConstant.kPrimaryColor,
      elevation: 0,
      title: Text(
       widget.title,
        style: TextStyle(
            fontSize: SizeConfig.textMultiplier * 2.2,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ).tr(),
    );
  }
}
