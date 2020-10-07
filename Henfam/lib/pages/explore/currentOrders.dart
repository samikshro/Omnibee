import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/pages/explore/deliveryCard.dart';
import 'package:Henfam/pages/explore/orderCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Henfam/bloc/blocs.dart';

class CurrentOrders extends StatelessWidget {
  BaseAuth _auth = Auth();

  Future<String> _getUserId() async {
    final user = await _auth.getCurrentUser();
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      if (state is OrderStateLoadSuccess) {
        return FutureBuilder<String>(
            future: _getUserId(),
            builder: (BuildContext context, AsyncSnapshot<String> uid) {
              print("inside builder\n");
              if (uid.hasData) {
                return ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    ExpansionTile(
                      title: Text(
                        'Your Orders',
                        style: TextStyle(fontSize: 18),
                      ),
                      children: state
                          .getUserOrders(uid.data)
                          .map<Widget>((order) => OrderCard(
                                context,
                                order: order,
                              ))
                          .toList(),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Your Deliveries',
                        style: TextStyle(fontSize: 18),
                      ),
                      children: state
                          .getUserDeliveries(uid.data)
                          .map<Widget>((order) => DeliveryCard(
                                context,
                                order: order,
                              ))
                          .toList(),
                    ),
                  ],
                );
              } else {
                print("In here\n");
                return CircularProgressIndicator();
              }
            });
      } else {
        return Container();
      }
    });
  }
}
