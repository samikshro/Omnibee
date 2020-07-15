import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigAcceptOrderInfo.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigDisplaySmallUsers.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/expandedDecouple.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/minEarnings.dart';
import 'package:Henfam/pages/map/map.dart';
import 'package:flutter/material.dart';

class AcceptOrder extends StatefulWidget {
  @override
  _AcceptOrderState createState() => _AcceptOrderState();
}

class _AcceptOrderState extends State<AcceptOrder> {
  final restaurant = {
    'name': 'Oishii Bowl',
    'location': [42.441947, -76.485066]
  };

  final requesters = [
    {
      'name': 'John',
      'small_image': Image(
        image: AssetImage('assets/man1.png'),
      ),
      'big_image': Image(
        image: AssetImage('assets/man1@2x.png'),
      ),
      'selected': true,
      'item_cost': 11.23,
      'min_earnings': 2.50,
      'location': [42.447866, -76.484200],
    },
    {
      'name': 'Kristen',
      'small_image': Image(
        image: AssetImage('assets/woman1.png'),
      ),
      'big_image': Image(
        image: AssetImage('assets/woman1@2x.png'),
      ),
      'selected': true,
      'item_cost': 15.23,
      'min_earnings': 3.20,
      'location': [42.444806, -76.482617],
    },
    {
      'name': 'Cooper',
      'small_image': Image(
        image: AssetImage('assets/man2.png'),
      ),
      'big_image': Image(
        image: AssetImage('assets/man2@2x.png'),
      ),
      'selected': true,
      'item_cost': 9.23,
      'min_earnings': 2.59,
      'location': [42.444054, -76.485805],
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    width: double.infinity,
                    height: 750,
                    child: Column(
                      children: <Widget>[
                        CustomMap(requesters, restaurant),
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
                        MinEarnings(requesters),
                        AcceptOrderInfo(requesters),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              fillOverscroll: true,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                      child: Text('Confirm', style: TextStyle(fontSize: 20.0)),
                      onPressed: () {}),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
