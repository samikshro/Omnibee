import 'package:Henfam/bloc/basket/basket_bloc.dart';
import 'package:Henfam/models/menu_item.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Basket extends StatelessWidget {
  Widget _buildTile(List<MenuItem> menuItems, int index) {
    return ListTile(
      onTap: () {},
      trailing: _getTrailing(menuItems[index]),
      title: Text(menuItems[index].name),
      subtitle: Wrap(
        direction: Axis.vertical,
        children: _getModifiersList(menuItems[index]),
      ),
      isThreeLine: true,
    );
  }

  Widget _getTrailing(MenuItem menuItem) {
    return BlocBuilder<BasketBloc, BasketState>(builder: (context, state) {
      return Column(
        children: <Widget>[
          Text(_getItemsPrice([menuItem])),
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.remove_circle,
                size: 20,
              ),
              onPressed: () {
                BlocProvider.of<BasketBloc>(context)
                    .add(MenuItemDeleted(menuItem));
              },
            ),
          )
        ],
      );
    });
  }

  List<Widget> _getModifiersList(MenuItem item) {
    List<Widget> modifiers = [];
    item.modifiersChosen.forEach((modifier) {
      modifiers.add(Text(modifier.name));
    });
    return modifiers;
  }

  String _getItemsPrice(List<MenuItem> items) {
    double price = 0.00;
    items.forEach((item) {
      price += item.price;
      item.modifiersChosen.forEach((modifier) {
        price += modifier.price;
      });
    });
    return price.toStringAsFixed(2);
  }

  Function _getOnPressed(BuildContext context, BasketLoadSuccess state) {
    return (state.menuItems.length == 0)
        ? null
        : () => Navigator.pushNamed(context, '/request');
  }

  List<String> _getDeliveryFeeAndTax(List<MenuItem> menuItems) {
    double totalPrice = 0.0;
    menuItems.forEach((item) {
      totalPrice += double.parse(_getItemPrice(item));
    });
    double deliveryFee = totalPrice * .2;
    double tax = .08 * (deliveryFee + totalPrice);
    double applicationFee = .03 * (totalPrice + deliveryFee + tax) + .3;
    double grandTotal = totalPrice + tax + applicationFee + deliveryFee;
    return [
      deliveryFee.toStringAsFixed(2),
      applicationFee.toStringAsFixed(2),
      tax.toStringAsFixed(2),
      grandTotal.toStringAsFixed(2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(builder: (context2, state) {
      return Scaffold(
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 60,
          child: RaisedButton(
            child: Text('Proceed to Request',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).scaffoldBackgroundColor)),
            onPressed: _getOnPressed(context, state),
          ),
        ),
        appBar: AppBar(
            title: Text(
          'My Basket',
        )),
        body: (state is BasketLoadSuccess)
            ? SafeArea(
                child: ListView(
                children: <Widget>[
                  LargeTextSection("Items"),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.menuItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildTile(state.menuItems, index);
                    },
                  ),
                  ListTile(
                    title: Text("Delivery Fee"),
                    trailing: Text(_getDeliveryFeeAndTax(state.menuItems)[0]),
                  ),
                  ListTile(
                    title: Text("Application Fee"),
                    trailing: Text(_getDeliveryFeeAndTax(state.menuItems)[1]),
                  ),
                  ListTile(
                    title: Text("Tax"),
                    trailing: Text(_getDeliveryFeeAndTax(state.menuItems)[2]),
                  ),
                  ListTile(
                    title: Text("Total"),
                    trailing: Text(_getDeliveryFeeAndTax(state.menuItems)[3]),

                  ),
                ],
              ))
            : Container(),
      );
    });
  }
}
