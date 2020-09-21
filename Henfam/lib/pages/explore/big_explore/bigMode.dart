import 'package:flutter/material.dart';
import 'bigCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BigMode extends StatefulWidget {
  @override
  _BigModeState createState() => _BigModeState();
}

class _BigModeState extends State<BigMode> {
  Timestamp tiempo = Timestamp.now();

  bool _allRunsAccepted(documents) {
    for (int i = 0; i < documents.length; i++) {
      if (documents[i]['user_id']['is_accepted'] == false) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Run Errand'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
            ),
            /* Container(
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
            ), */
            Flexible(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('orders')
                      .where("user_id.expiration_time",
                          isGreaterThanOrEqualTo: new DateTime.now())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (_allRunsAccepted(snapshot.data.documents)) {
                      return Center(
                        child: Text(
                          'No runs currently available',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );
                    }
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
