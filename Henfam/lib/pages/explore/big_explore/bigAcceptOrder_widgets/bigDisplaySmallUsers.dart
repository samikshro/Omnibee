import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigIconNameRow.dart';
import 'package:flutter/material.dart';

class DisplaySmallUsers extends StatelessWidget {
  bool isExpanded;
  List<Map<String, Object>> requesters;

  DisplaySmallUsers(this.isExpanded, this.requesters);

  @override
  Widget build(BuildContext context) {
    if (!isExpanded) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: (IconNameRow(requesters)),
      );
    } else {
      return Container();
    }
  }
}
