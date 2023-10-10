
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/constants/icons.dart';
import 'package:services_finder/utils/size_config.dart';

class BottomWhatsappButton extends StatelessWidget {
  const BottomWhatsappButton({
    Key? key,
    required this.onTap
  }) : super(key: key);
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 9,
      width: SizeConfig.widthMultiplier * 100,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)]),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: SizeConfig.heightMultiplier * 6,
            width: SizeConfig.widthMultiplier * 85,
            decoration:  BoxDecoration(color:const Color(0xFF28a71a),borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconsConstant.whatsapp,
                  height: SizeConfig.heightMultiplier * 3,
                  color: Colors.white,
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 2,
                ),
                Text(
                  "Rent with WhatsApp",
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ).tr()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
