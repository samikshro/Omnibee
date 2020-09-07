import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/bloc/basket/basket_bloc.dart';
import 'package:Henfam/bloc/menu_order_form/menu_order_form_bloc.dart';
import 'package:Henfam/models/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  List<MenuItem> _getAddOns(items, selectedAddOns) {
    List<MenuItem> finalAddOns = [];
    for (int i = 0; i < selectedAddOns.length; i++) {
      if (selectedAddOns[i]) {
        finalAddOns.add(
          MenuItem(
            items[i]['name'],
            '',
            items[i]['price'].toDouble(),
            [],
          ),
        );
      }
    }

    return finalAddOns;
  }

  double _getPrice(item, selectedAddOns) {
    double finalPrice = item['price'];
    for (int i = 0; i < selectedAddOns.length; i++) {
      if (selectedAddOns[i]) {
        finalPrice += item['add_ons'][i]['price'];
      }
    }

    return num.parse(finalPrice.toStringAsFixed(2)).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    /* for (int i = 0; i < addOns.length; i++) {
      _addOnsSelected.add(false);
    } */
    return BlocBuilder<MenuOrderFormBloc, MenuOrderFormState>(
        builder: (context3, state3) {
      return (state3 is MenuOrderFormLoadSuccess)
          ? BlocBuilder<BasketBloc, BasketState>(builder: (context2, state) {
              return (state is BasketLoadSuccess)
                  ? Scaffold(
                      bottomNavigationBar: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: RaisedButton(
                          child: Text('Add to Cart',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor)),
                          onPressed: () {
                            if (state3 is MenuOrderFormLoadSuccess) {
                              BlocProvider.of<BasketBloc>(context2)
                                  .add(MenuItemAdded(state3.menuItem));
                            }

                            Navigator.pop(context);
                          },
                        ),
                      ),
                      appBar: AppBar(
                          title: Text(
                        state3.menuItem.name,
                      )),
                      body: SafeArea(
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                                child: Text(
                                  state3.menuItem.description,
                                  //args.desc,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: LargeTextSection("Add-ons"),
                            ),
                            SliverToBoxAdapter(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state3.menuItem.addOns.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        CheckboxListTile(
                                  title:
                                      Text(state3.menuItem.addOns[index].name),
                                  subtitle: Text('1'),
                                  value: _addOnsSelected[index],
                                  onChanged: (value) {
                                    _selectAddOn(value, index);
                                  },
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                                child: LargeTextSection("Special Requests")),
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
                    )
                  : Container();
            })
          : Container();
    });
  }
}
