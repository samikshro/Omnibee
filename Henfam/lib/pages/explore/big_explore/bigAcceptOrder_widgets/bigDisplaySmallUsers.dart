import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigIconNameRow.dart';
import 'package:flutter/material.dart';

class DisplaySmallUsers extends StatelessWidget {
  bool isExpanded;
  List<Map<String, Object>> requesters;

  DisplaySmallUsers(this.isExpanded, this.requesters);

  @override
  Widget build(BuildContext context) {
    if (!isExpanded) {
      return (ListTile(
        dense: true,
        leading: FlutterLogo(),
        title: IconNameRow(requesters),
      ));
    } else {
      return Container();
    }
  }
}
