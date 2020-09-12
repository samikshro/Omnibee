import 'package:Henfam/bloc/basket/basket_bloc.dart';
import 'package:Henfam/models/menu_item.dart';
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
      ),
      isThreeLine: true,
    );
  }

  Widget _getTrailing(MenuItem menuItem) {
    return BlocBuilder<BasketBloc, BasketState>(builder: (context, state) {
      return Column(
        children: <Widget>[
          Text(menuItem.price.toString()),
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

  Function _getOnPressed(BuildContext context, BasketLoadSuccess state) {
    return (state.menuItems.length == 0)
        ? null
        : () => Navigator.pushNamed(context, '/request');
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
