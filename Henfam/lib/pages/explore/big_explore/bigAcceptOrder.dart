import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigAcceptOrderInfo.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigDisplaySmallUsers.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/expandedDecouple.dart';
import 'package:Henfam/pages/map/map.dart';
import 'package:flutter/material.dart';

class AcceptOrder extends StatefulWidget {
  @override
  _AcceptOrderState createState() => _AcceptOrderState();
}

class _AcceptOrderState extends State<AcceptOrder> {
  final requesters = [
    {
      'name': 'John',
      'image': Image(
        image: AssetImage('assets/beeperson@2x.png'),
      ),
      'selected': true,
    },
    {
      'name': 'Lisa',
      'image': Image(
        image: AssetImage('assets/beeperson@2x.png'),
      ),
      'selected': true,
    },
  ];
  var displayBigUsers = false;

  void _changeCheckBox(Map<String, Object> requester, bool modifiedVal) {
    setState(() {
      requester['selected'] = modifiedVal;
    });
  }

  void _onExpand(bool is_expanded) {
    setState(() {
      displayBigUsers = is_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomMap(),
          ExpansionTile(
            title: Text('3 requests'),
            onExpansionChanged: _onExpand,
            trailing: Text(
              'DECOUPLE',
              style: TextStyle(color: Colors.cyan),
            ),
            children: <Widget>[
              ExpandedDecouple(requesters, _changeCheckBox),
            ],
          ),
          DisplaySmallUsers(displayBigUsers, requesters),
          AcceptOrderInfo(),
        ],
      ),
    );
  }
}
