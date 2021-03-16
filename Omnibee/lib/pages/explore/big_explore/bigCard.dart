import 'package:Omnibee/bloc/blocs.dart';
import 'package:Omnibee/entities/entities.dart';
import 'package:Omnibee/models/models.dart';
import 'package:Omnibee/services/paymentService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  int _loading = 0;

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

  Widget _setUpButtonChild() {
    if (_loading == 0) {
      return Text("Set Up Payments");
    } else if (_loading == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void _setupStripeAccount(User user) {
    PaymentService.createAccount(user.email);
  }

  void _updateStripeAccount(String accountId) {
    bool updateEnabled = false;
    if (updateEnabled)
      PaymentService.updateAccountLink(accountId);
    else
      PaymentService.createAccountLink(accountId);
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
                      Firestore.instance
                          .collection('users')
                          .document((state as Authenticated).user.uid)
                          .get()
                          .then((DocumentSnapshot document) {
                        User user =
                            User.fromEntity(UserEntity.fromSnapshot(document));
                        if (user.stripeSetupComplete) {
                          Navigator.pushNamed(context, '/accept_order',
                              arguments: widget.order);
                        } else {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: Text(
                                      'Setup a payment account to get paid after your delivery!',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: Text(
                                        'Please wait up to 10 seconds for the form to load.',
                                        style: TextStyle(fontSize: 19)),
                                  ),
                                  CupertinoButton(
                                      color: Theme.of(context).primaryColor,
                                      child: _setUpButtonChild(),
                                      onPressed: () {
                                        if (user != null) {
                                          user.stripeAccountId == ""
                                              ? _setupStripeAccount(user)
                                              : _updateStripeAccount(
                                                  user.stripeAccountId);
                                        }
                                      }),
                                ],
                              );
                            },
                          );
                        }
                      });
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
