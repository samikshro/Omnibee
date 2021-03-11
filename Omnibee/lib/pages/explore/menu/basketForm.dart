import 'package:Omnibee/bloc/basket/basket_bloc.dart';
import 'package:Omnibee/models/menu_item.dart';
import 'package:Omnibee/services/paymentService.dart';
import 'package:flutter/material.dart';
import 'package:Omnibee/widgets/largeTextSection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Basket extends StatelessWidget {
  final double itemFontSize = 19;
  Widget _buildTile(
    List<MenuItem> menuItems,
    int index,
    double modifiersWidth,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: ListTile(
        onTap: () {},
        trailing: _getTrailing(menuItems[index]),
        title: Text(
          menuItems[index].name,
          style: TextStyle(
            fontSize: itemFontSize,
          ),
        ),
        subtitle: Wrap(
          direction: Axis.vertical,
          children: _getModifiersListAndSpecialRequest(
              menuItems[index], modifiersWidth),
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _getTrailing(MenuItem menuItem) {
    return BlocBuilder<BasketBloc, BasketState>(builder: (context, state) {
      return Column(
        children: <Widget>[
          Text(
            _getItemsPrice([menuItem]),
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.remove_circle,
                size: 20,
                color: Colors.red,
              ),
              onPressed: () {
                BlocProvider.of<BasketBloc>(context)
                    .add(MenuItemDeleted(menuItem));
                if ((state as BasketLoadSuccess).menuItems.length == 0) {
                  Navigator.pop(context);
                }
              },
            ),
          )
        ],
      );
    });
  }

  List<Widget> _getModifiersListAndSpecialRequest(MenuItem item, double width) {
    List<Widget> modifiersAndSpecialRequest = [];
    item.modifiersChosen.forEach((modifier) {
      modifiersAndSpecialRequest.add(Text('\n${modifier.name}'));
    });

    if (item.specialRequests.length >= 1) {
      modifiersAndSpecialRequest.add(SizedBox(
        width: width,
        child: Text(
          '\nSpecial Request: ${item.specialRequests}\n',
          overflow: TextOverflow.clip,
        ),
      ));
    }

    return modifiersAndSpecialRequest;
  }

  // TODO: put modifier prices inside of order, not just display
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
    double subtotal = double.parse(_getItemsPrice(menuItems));

    return [
      PaymentService.getTotalFees(subtotal).toStringAsFixed(2),
      (PaymentService.getTaxedPrice(subtotal) - subtotal).toStringAsFixed(2),
      PaymentService.getPCharge(subtotal).toStringAsFixed(2),
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
        body: ((state is BasketLoadSuccess) && (state.menuItems.length > 0))
            ? SafeArea(
                child: ListView(
                children: <Widget>[
                  LargeTextSection("Items"),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.menuItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildTile(
                        state.menuItems,
                        index,
                        (MediaQuery.of(context).size.width / 3) * 2,
                      );
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  ListTile(
                    title: Text(
                      "Delivery Fee",
                      style: TextStyle(fontSize: itemFontSize),
                    ),
                    trailing: Text(_getDeliveryFeeAndTax(state.menuItems)[0]),
                  ),
                  ListTile(
                    title: Text(
                      "Tax",
                      style: TextStyle(fontSize: itemFontSize),
                    ),
                    trailing: Text(_getDeliveryFeeAndTax(state.menuItems)[1]),
                  ),
                  ListTile(
                    title: Text(
                      "Total",
                      style: TextStyle(fontSize: itemFontSize),
                    ),
                    trailing: Text(_getDeliveryFeeAndTax(state.menuItems)[2]),
                  ),
                ],
              ))
            : Container(),
      );
    });
  }
}
