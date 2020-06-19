import 'package:flutter/material.dart';
import 'package:Henfam/models/errandModel.dart';

class ErrandCard extends StatelessWidget {
  final String bigHenName;
  final String bigHenImage;
  final String timeFrame;
  final String location;
  final String destination;
  final ErrandType type;
  final int requestLimit;

  ErrandCard({
    this.bigHenName,
    this.bigHenImage,
    this.timeFrame,
    this.location,
    this.destination,
    this.type,
    this.requestLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
            child: Image(
              image: AssetImage(bigHenImage),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: 220,
              height: 165,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: 210,
                    color: Colors.grey[700],
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "$bigHenName is getting food from",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "$location",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ]),
                    ),
                  ),
                  Container(
                    width: 210,
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "$timeFrame @",
                            ),
                            Text(
                              "$destination",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Limit: $requestLimit requests",
                            ),
                          ]),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 30,
                    child: RaisedButton(
                      color: Colors.amber,
                      onPressed: () {},
                      child: Text(
                        "Count Me In",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
