import 'package:flutter/material.dart';
import 'package:Henfam/models/AddOnModel.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodDocument {
  final DocumentSnapshot document;
  final int index;
  FoodDocument({this.document, this.index});
}

class MenuOrderForm extends StatefulWidget {
  @override
  _MenuOrderFormState createState() => _MenuOrderFormState();
}

List<String> selectedAddons = [];

class _MenuOrderFormState extends State<MenuOrderForm> {
  final firestoreInstance = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    final FoodDocument foodDoc = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            foodDoc.document['food'][foodDoc.index]['name'],
            // style: TextStyle(color: Colors.black),
          )),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                child: Text(
                  foodDoc.document['food'][foodDoc.index]['desc'],
                  //args.desc,
                  style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: LargeTextSection("Add-ons"),
            ),
            // SliverList(
            //   delegate: SliverChildListDelegate(
            //     [
            //       Container(
            //         height: 90.0 * args.addOns.length,
            //         child: ListView.separated(
            //           separatorBuilder: (context, index) {
            //             return Divider();
            //           },
            //           itemCount: args.addOns.length,
            //           itemBuilder: (context, index) {
            //             return CheckboxListTile(
            //               title: Text(args.addOns[index].name),
            //               subtitle: Wrap(direction: Axis.vertical, children: [
            //                 Text("\$" + args.addOns[index].price.toString()),
            //               ]),
            //               value:
            //                   selectedAddons.contains(args.addOns[index].name),
            //               onChanged: (bool value) {
            //                 setState(() {
            //                   if (value) {
            //                     selectedAddons.add(args.addOns[index].name);
            //                   } else {
            //                     selectedAddons.remove(args.addOns[index].name);
            //                   }
            //                 });
            //               },
            //             );
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
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
                    child:
                        Text('Add to Cart', style: TextStyle(fontSize: 20.0)),
                    color: Colors.amberAccent,
                    onPressed: () {
                      firestoreInstance.collection("orders").add({
                        "user_id": {
                          "name": "Ada Lovelace",
                          // Index Ada's groups in her profile
                          "rest_name_used": "Oishii Bowl",
                          "basket": [
                            {
                              "name": foodDoc.document['food'][foodDoc.index]
                                  ['name'],
                              "price": foodDoc.document['food'][foodDoc.index]
                                  ['price'],
                            },
                          ],
                          //"delivery_date": "",
                          //"delivery_range": "",
                          //"total_fee": "", //don't know if we need this
                          //"order_expiration_time": "",
                          //"deliver_to_location": "",
                        }
                      }).then((value) {
                        print(value.documentID);
                      });
                      Navigator.pop(context, foodDoc); //, args);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
