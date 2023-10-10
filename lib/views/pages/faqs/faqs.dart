import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/custom_appbar.dart';
import 'package:services_finder/views/widgets/loading.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "FAQ's"),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("FAQS")
                  .orderBy('id')
                  .snapshots(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? LoadingWidget(height: SizeConfig.heightMultiplier * 90)
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier*2,
                            horizontal: SizeConfig.widthMultiplier * 5),
                        itemBuilder: (_, i) => ExpandablePanel(
                          header: Text(
                            snapshot.data!.docs[i].get("Question"),
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.8,
                                fontWeight: FontWeight.w600),
                          ),
                          collapsed: const Text(
                            "",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          expanded: Padding(
                            padding:  EdgeInsets.only(bottom: SizeConfig.heightMultiplier*2),
                            child: Text(
                              snapshot.data!.docs[i].get("Answer"),
                              softWrap: true,
                              style: TextStyle(fontSize: SizeConfig.textMultiplier*1.6),
                            ),
                          ),
                        ));
              })
        ],
      ),
    );
  }
}
