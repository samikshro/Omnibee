import 'package:flutter/material.dart';
import 'package:Henfam/models/AddOnModel.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class FoodInfo {
  final String name;
  final String desc;
  final String price;
  final List<AddOns> addOns;
  int quantity;

  FoodInfo({this.name, this.desc, this.price, this.quantity, this.addOns});
}

class MenuOrderForm extends StatefulWidget {
  @override
  _MenuOrderFormState createState() => _MenuOrderFormState();
}

class _MenuOrderFormState extends State<MenuOrderForm> {
  @override
  Widget build(BuildContext context) {
    final FoodInfo args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            args.name,
            // style: TextStyle(color: Colors.black),
          )),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                child: Text(
                  args.desc,
                  style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: LargeTextSection("Add-ons"),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 100.0 * args.addOns.length,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: args.addOns.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          // onTap: () {
                          //   Navigator.pushNamed(
                          //     context,
                          //     '/menu_order_form',
                          //     arguments: FoodInfo(
                          //       name: list[0].food[index].name,
                          //       desc: list[0].food[index].desc,
                          //       price: list[0].food[index].price,
                          //       addOns: list[0].food[index].addOns,
                          //       quantity: 1,
                          //     )
                          //   );
                          // },
                          title: Text(args.addOns[index].name),
                          subtitle: Wrap(direction: Axis.vertical, children: [
                            Text("\$" + args.addOns[index].price.toString()),
                          ]),
                          value: timeDilation != 1.0,
                          onChanged: (bool value) {
                            setState(() {
                              timeDilation = value ? 1.0 : 2.0;
                            });
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(child: LargeTextSection("Special Requests")),
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
                    //fromRGBO(253, 152, 39, 1),
                    onPressed: () {},
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
