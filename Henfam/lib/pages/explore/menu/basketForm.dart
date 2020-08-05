import 'package:Henfam/bloc/basket/basket_bloc.dart';
import 'package:Henfam/models/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Basket extends StatelessWidget {
  List<Widget> _displayAddOns(MenuItem menuItem) {
    List<Widget> addOns = [];
    if (menuItem.addOns != null) {
      for (int i = 0; i < menuItem.addOns.length; i++) {
        addOns.add(Text(menuItem.addOns[i].name));
      }
    }

    return addOns;
  }

  Widget _buildTile(List<MenuItem> menuItems, int index) {
    return ListTile(
      onTap: () {},
      trailing: Text(menuItems[index].price.toString()),
      title: Text(menuItems[index].name),
      subtitle: Wrap(
        direction: Axis.vertical,
        children: _displayAddOns(menuItems[index]),
      ),
      isThreeLine: true,
    );
  }

  Widget getTrailing(int index) {
    return Column(
      children: <Widget>[
        //Text("\$" + args.orders[index].price.toStringAsFixed(2)),
        Expanded(
          child: FlatButton(
            child: Icon(
              Icons.remove_circle,
              size: 20,
            ),
            onPressed: () {
              //deleteItem(index);
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 60,
          child: RaisedButton(
            child: Text('Proceed to Request',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).scaffoldBackgroundColor)),
            onPressed: () {
              Navigator.pushNamed(context, '/request');
            },
          ),
        ),
        appBar: AppBar(
            title: Text(
          'My Basket',
        )),
        body: (state is BasketLoadSuccess)
            ? SafeArea(
                child: Column(
                children: <Widget>[
                  LargeTextSection("Items"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.menuItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildTile(state.menuItems, index);
                    },
                  )
                ],
              ))
            : Container(),
      );
    });
  }
}
