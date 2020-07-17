import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigIconNameRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplaySmallUsers extends StatelessWidget {
  bool isExpanded;
  List<DocumentSnapshot> requests;
  List<bool> selectedList;

  DisplaySmallUsers(this.isExpanded, this.requests, this.selectedList);

  @override
  Widget build(BuildContext context) {
    if (!isExpanded) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: (IconNameRow(requests, selectedList)),
      );
    } else {
      return Container();
    }
  }
}
