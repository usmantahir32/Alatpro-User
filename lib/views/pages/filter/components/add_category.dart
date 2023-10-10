import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/utils/size_config.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({
    Key? key,
    required this.list,
    required this.heading,
    required this.onAdd,
  }) : super(key: key);
  final List list;
  final String heading;
  final VoidCallback onAdd;

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2,
              fontWeight: FontWeight.w700),
        ).tr(),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1,
        ),
        Container(
          height: SizeConfig.heightMultiplier * 6,
          width: SizeConfig.widthMultiplier * 90,
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(6)),
          padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
          child: Row(
            children: [
              SizedBox(
                width: SizeConfig.widthMultiplier * 74,
                child: widget.list.isEmpty
                    ? Text("${tr('Please add')} ${widget.heading.toLowerCase()}").tr()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            ...List.generate(
                                widget.list.length,
                                (index) => Container(
                                      height: SizeConfig.heightMultiplier * 3.5,
                                      // width: SizeConfig.widthMultiplier * 27,
                                      margin: EdgeInsets.only(
                                          right:
                                              SizeConfig.widthMultiplier * 2),
                                      decoration: BoxDecoration(
                                          color: ColorsConstant.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(70)),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width:
                                                SizeConfig.widthMultiplier * 3,
                                          ),
                                          Text(
                                            widget.list[index],
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        1.7,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width:
                                                SizeConfig.widthMultiplier * 2,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              widget.list
                                                  .remove(widget.list[index]);
                                              setState(() {});
                                            },
                                            child: CircleAvatar(
                                              radius:
                                                  SizeConfig.widthMultiplier *
                                                      2.5,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                FeatherIcons.x,
                                                color: Colors.grey.shade800,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: SizeConfig.widthMultiplier *
                                                1.5,
                                          ),
                                        ],
                                      ),
                                    )),
                          ],
                        ),
                      ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: widget.onAdd,
                child: Container(
                  height: SizeConfig.heightMultiplier * 7,
                  width: SizeConfig.widthMultiplier * 11,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6)),
                      color: Colors.amber.shade100),
                  child: Icon(
                    Icons.add,
                    size: SizeConfig.textMultiplier * 3.5,
                    color: ColorsConstant.kPrimaryColor,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
