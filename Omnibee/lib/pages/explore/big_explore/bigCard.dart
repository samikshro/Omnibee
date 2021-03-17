import 'package:Omnibee/bloc/blocs.dart';
import 'package:Omnibee/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BigCard extends StatefulWidget {
  final Order order;

  BigCard(BuildContext context, {this.order});

  @override
  _BigCardState createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  List<Widget> _itemsToOrder(Order order) {
    List<Widget> children = [];
    for (int i = 0; i < order.basket.length; i++) {
      children.add(ListTile(
        title: Text(
          order.basket[i]['name'],
        ),
        trailing: Text(order.basket[i]['price'].toStringAsFixed(2)),
      ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.order.isAccepted == true) {
      return Container();
    }
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      print("Rebuilt");
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/accept_order',
              arguments: widget.order);
        },
        child: Card(
          margin: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ExpansionTile(
                leading: Icon(Icons.fastfood),
                title: Text(
                  "${widget.order.restaurantName} to ${widget.order.location}",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: _itemsToOrder(widget.order),
              ),
              Text(
                "Minimum Earnings: \$${widget.order.minEarnings.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.right,
              ),
              Text(
                "Deliver Between: ${widget.order.startTime} - ${widget.order.endTime}\n",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
              ),
              Image(
                image: AssetImage(widget.order.restaurantImage),
                fit: BoxFit.cover,
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text(
                      'VIEW',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/accept_order',
                          arguments: widget.order);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
