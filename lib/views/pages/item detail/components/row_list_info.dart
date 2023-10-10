
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/utils/size_config.dart';

class RowListInfo extends StatelessWidget {
  const RowListInfo({
    Key? key,
    required this.title,
    required this.list,
  }) : super(key: key);
  final String title;
  final List list;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 1.9,
              fontWeight: FontWeight.w600,
            ),
          ).tr(),
          Container(
            width:SizeConfig.widthMultiplier*60,
            
            child: Wrap(
              alignment: WrapAlignment.end,
              children: [
                ...List.generate(list.length, (index) =>  Text(
            "${list[index]}${index==list.length-1?"":", "}",
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 1.9,
              fontWeight: FontWeight.w600,
            ),
          ))
              ],
            )),
        ],
      ),
    );
  }
}
