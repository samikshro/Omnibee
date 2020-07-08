import 'package:flutter/material.dart';
import 'bigCard.dart';
import 'package:Henfam/widgets/largeTextSection.dart';

class BigMode extends StatefulWidget {
  @override
  _BigModeState createState() => _BigModeState();
}

class _BigModeState extends State<BigMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(10),
        ),
        LargeTextSection('Run Errand'),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white54,
                ),
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.white54,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.tune,
                    color: Colors.white54,
                  ),
                  tooltip: 'Filter',
                  onPressed: () {
                    print('hit filter');
                  },
                )),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return BigCard();
                }))
      ]),
    );
  }
}
