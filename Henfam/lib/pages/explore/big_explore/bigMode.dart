import 'package:flutter/material.dart';
import 'bigCard.dart';

class BigMode extends StatefulWidget {
  @override
  _BigModeState createState() => _BigModeState();
}

class _BigModeState extends State<BigMode> {
  bool isExpanded;

  // @override
  // void initState() {
  //   this.isExpanded = false;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          BigCard(),
          // CurrentOrder("Jessie", "7:30", "on the way"),
          // ScheduledRequests(),
          // LargeTextSection("What would you like help with, John?"),
          // Container(
          //   child: HelpCard(activities),
          // ),
          // LargeTextSection("Or choose from other errands nearby!"),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 60),
          //   child: ErrandsNearby(),
          // ),
        ],
      ),
      //     body: Column(
      //   children: <Widget>[
      //     Expanded(
      //       child: ListView.builder(
      //         scrollDirection: Axis.horizontal,
      //         itemCount: 2,
      //         itemBuilder: (BuildContext context, int index) {
      //           return Text('HHHHello');
      //         },
      //       ),
      //     )
      //   ],
      // )
      //     body: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Expanded(
      //         child: ExpansionPanelList(
      //           expansionCallback: (int index, bool isExpanded) {
      //             setState(() {
      //               this.isExpanded = !isExpanded;
      //             });
      //           },
      //           children: <ExpansionPanel>[
      //             new ExpansionPanel(
      //               headerBuilder: (BuildContext context, bool isExpanded) =>
      //                   const Text("header data"),
      //               body: const Text("Body data"),
      //               isExpanded: this.isExpanded,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // )
    );
  }
}
