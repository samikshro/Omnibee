import 'package:flutter/material.dart';
import 'package:Henfam/widgets/largeTextSection.dart';

// class BasketData {
//   final
// }

class Basket extends StatefulWidget {
  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text(
              'My Basket',
              // style: TextStyle(color: Colors.black),
            )),
        body: SafeArea(
            child: CustomScrollView(
          slivers: <Widget>[
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
            //     child: Text(
            //       args.desc,
            //       style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: LargeTextSection("Items"),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [],
              ),
            ),
            SliverToBoxAdapter(child: LargeTextSection("Special Requests")),
            SliverToBoxAdapter(
              child: Container(
                  child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Requests',
                ),
              )),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll:
                  true, // Set true to change overscroll behavior. Purely preference.
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                    child: Text('Proceed to Request',
                        style: TextStyle(fontSize: 20.0)),
                    color: Colors.amberAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, '/request');
                    },
                  ),
                ),
              ),
            )
          ],
        )));
  }
}
