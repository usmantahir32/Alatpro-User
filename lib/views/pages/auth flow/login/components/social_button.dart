import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/constants/icons.dart';
import 'package:services_finder/utils/size_config.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.onTap,
    required this.isFacebook,
  }) : super(key: key);
  final VoidCallback onTap;
  final bool isFacebook;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.heightMultiplier * 6,
        width: SizeConfig.widthMultiplier * 90,
        margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isFacebook ? IconsConstant.facebook : IconsConstant.google,
              height: SizeConfig.heightMultiplier * 3,
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 3,
            ),
            Text(
              isFacebook ? "Sign in with Facebook" : "Sign in with Google",
              style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 2,
                  fontWeight: FontWeight.w600),
            ).tr()
          ],
        ),
      ),
    );
  }
}
