import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:services_finder/constants/colors.dart';

import '../../utils/size_config.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    final spinKit = SpinKitThreeBounce(
      color: ColorsConstant.kPrimaryColor,
    );
    return SizedBox(
      height: height,
      width: SizeConfig.widthMultiplier * 100,
      child: Center(
          child: SizedBox(
              height: SizeConfig.heightMultiplier * 8, child: spinKit)),
    );
  }
}
