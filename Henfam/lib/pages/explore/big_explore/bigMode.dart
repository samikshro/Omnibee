import 'package:flutter/material.dart';
import 'bigCard.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BigMode extends StatefulWidget {
  @override
  _BigModeState createState() => _BigModeState();
}

class _BigModeState extends State<BigMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
            ),
            LargeTextSection('Run Errand'),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.tune,
                      ),
                      tooltip: 'Filter',
                      onPressed: () {
                        Navigator.pushNamed(context, '/big_filter');
                        //,arguments: BasketData(orders: ord.order));
                      },
                    )),
              ),
            ),
            Flexible(
              child: StreamBuilder(
                  stream: Firestore.instance.collection('orders').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('Loading....');
                    print("length of snapshot: " +
                        snapshot.data.documents.length.toString());
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BigCard(context,
                              document: snapshot.data.documents[index]);
                        });
                  }),
            ),
          ]),
    );
  }
}
