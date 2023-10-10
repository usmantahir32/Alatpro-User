import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:services_finder/constants/colors.dart';
import '../../../../utils/size_config.dart';

class ChooseSourceDialog extends StatefulWidget {
  const ChooseSourceDialog({
    Key? key,
    required this.onGalleryPress,
    required this.onCameraPress,
  });
  final VoidCallback onGalleryPress;
  final VoidCallback onCameraPress;
  @override
  State<StatefulWidget> createState() => ChooseSourceDialogState();
}

class ChooseSourceDialogState extends State<ChooseSourceDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  TextEditingController nameCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
            height: 15 * SizeConfig.heightMultiplier,
            width: 60 * SizeConfig.widthMultiplier,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier * 4,
                horizontal: SizeConfig.widthMultiplier * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: widget.onCameraPress,
                  child: Column(
                    children: [
                     Icon(FeatherIcons.camera,color: ColorsConstant.kPrimaryColor,),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                       Text(
                        "Camera",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: ColorsConstant.kPrimaryColor,),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: widget.onGalleryPress,
                  child: Column(
                    children: [
                       Icon(FeatherIcons.image,color: ColorsConstant.kPrimaryColor,),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                       Text(
                        "Gallery",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: ColorsConstant.kPrimaryColor,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
