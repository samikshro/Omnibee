import 'package:Henfam/auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodInfo {
  String name;
  List<String> addOns;
  double price;

  FoodInfo({
    this.name,
    this.addOns,
    this.price,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'add_ons': addOns,
        'price': price,
      };
}

class FoodDocument {
  final DocumentSnapshot document;
  final int index;
  List<FoodInfo> order;

  FoodDocument({
    this.document,
    this.index,
    this.order,
  });
}

class MenuOrderForm extends StatefulWidget {
  BaseAuth auth = new Auth();

  @override
  _MenuOrderFormState createState() => _MenuOrderFormState();
}

List<String> selectedAddons = [];

class _MenuOrderFormState extends State<MenuOrderForm> {
  final _addOnsSelected = [];

  void _selectAddOn(bool value, int index) {
    setState(() {
      _addOnsSelected[index] = value;
    });
  }

  List<String> _getAddOns(items, selectedAddOns) {
    List<String> finalAddOns = [];
    for (int i = 0; i < selectedAddOns.length; i++) {
      if (selectedAddOns[i]) {
        finalAddOns.add(items[i]['name']);
      }
    }

    return finalAddOns;
  }

  double _getPrice(item, selectedAddOns) {
    double finalPrice = item['price'];
    for (int i = 0; i < selectedAddOns.length; i++) {
      if (selectedAddOns[i]) {
        print(item['add_ons'][i]['price']);
        finalPrice += item['add_ons'][i]['price'];
      }
    }

    return finalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final FoodDocument foodDoc = ModalRoute.of(context).settings.arguments;
    final addOns = foodDoc.document['food'][foodDoc.index]['add_ons'];

    for (int i = 0; i < addOns.length; i++) {
      _addOnsSelected.add(false);
    }

    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          child: Text('Add to Cart',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).scaffoldBackgroundColor)),
          onPressed: () {
            if (foodDoc.order != null) {
              foodDoc.order.add(
                FoodInfo(
                  name: foodDoc.document['food'][foodDoc.index]['name'],
                  addOns: _getAddOns(
                    foodDoc.document['food'][foodDoc.index]['add_ons'],
                    _addOnsSelected,
                  ),
                  price: _getPrice(
                    foodDoc.document['food'][foodDoc.index],
                    _addOnsSelected,
                  ),
                ),
              );
            } else {
              foodDoc.order = [
                FoodInfo(
                  name: foodDoc.document['food'][foodDoc.index]['name'],
                  addOns: _getAddOns(
                    foodDoc.document['food'][foodDoc.index]['add_ons'],
                    _addOnsSelected,
                  ),
                  price: _getPrice(
                    foodDoc.document['food'][foodDoc.index],
                    _addOnsSelected,
                  ),
                ),
              ];
            }
            Navigator.pop(
                context,
                FoodDocument(
                  document: foodDoc.document,
                  index: foodDoc.index,
                  order: foodDoc.order,
                ));
          },
        ),
      ),
      appBar: AppBar(
          title: Text(
        foodDoc.document['food'][foodDoc.index]['name'],
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
            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    foodDoc.document['food'][foodDoc.index]['add_ons'].length,
                itemBuilder: (BuildContext context, int index) =>
                    CheckboxListTile(
                  title: Text(foodDoc.document['food'][foodDoc.index]['add_ons']
                      [index]['name']),
                  value: _addOnsSelected[index],
                  onChanged: (value) {
                    _selectAddOn(value, index);
                  },
                ),
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
          ],
        ),
      ),
    );
  }
}
