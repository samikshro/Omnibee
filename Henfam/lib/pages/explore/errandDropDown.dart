import 'package:Henfam/models/errandModel.dart';
import 'package:Henfam/widgets/notificationCircle.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/pages/explore/lilCard.dart';

class ErrandDropDown extends StatelessWidget {
  final String caption;
  final List<ErrandModel> errands;

  ErrandDropDown(this.caption, this.errands);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: <Widget>[
          Text(caption),
          NotificationCircle(errands.length),
        ],
      ),
      children: <Widget>[
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: errands.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return LilCard(
                bigHenImage: errands[index].bigHenImage,
                bigHenName: errands[index].bigHenName,
                location: errands[index].location,
                destination: errands[index].destination,
                requestLimit: errands[index].requestLimit,
                timeFrame: errands[index].timeFrame,
                type: errands[index].type,
              );
            })
      ],
    );
  }
}
