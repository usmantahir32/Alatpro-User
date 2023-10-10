import 'package:flutter/material.dart';
import 'package:services_finder/utils/size_config.dart';

class RowButton extends StatelessWidget {
  const RowButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isDivider=true
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final bool? isDivider;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.heightMultiplier * 8,
        width: SizeConfig.widthMultiplier * 100,
        color: Colors.white,
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.widthMultiplier * 80,
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey.shade700,
                  size: SizeConfig.widthMultiplier * 5,
                )
              ],
            ),
          isDivider!?  Divider(
              color: Colors.grey,
              height: SizeConfig.heightMultiplier * 2,
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}
