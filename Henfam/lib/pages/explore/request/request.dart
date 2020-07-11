import 'package:Henfam/pages/explore/matching_progress/matchingProgress.dart';
import 'package:Henfam/pages/explore/request/widgets/deliveryOptions.dart';
import 'package:Henfam/pages/explore/request/widgets/locationDetails.dart';
import 'package:Henfam/pages/explore/request/widgets/paymentSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/pages/explore/request/requestConfirm.dart';
import 'package:Henfam/pages/explore/menu/basketForm.dart';
import 'package:Henfam/auth/authentication.dart';

class Request extends StatefulWidget {
  BaseAuth auth = new Auth();
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  var _deliveryDate = DateTime.now();
  var _deliveryRange = DateTime(0, 0, 0, 0, 0);
  final _location = "Olin Library";

  void _setDeliveryDate(DateTime _newDate) {
    setState(() {
      _deliveryDate = _newDate;
    });
  }

  void _setDeliveryRange(DateTime _newRange) {
    setState(() {
      _deliveryRange = _newRange;
    });
  }

  Future<String> _getUserID() async {
    final result = await widget.auth.getCurrentUser();
    return result.uid;
  }

  @override
  Widget build(BuildContext context) {
    final BasketData args = ModalRoute.of(context).settings.arguments;
    if (args == null) {
      print("args is null st request.dart");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'Your Order',
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: <Widget>[
                      DeliveryOptions(_setDeliveryDate, _setDeliveryRange),
                      LocationDetails(_location),
                      PaymentSection(),
                    ],
                  ),
                ],
              ),
            ),
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
                        Text('Submit Order', style: TextStyle(fontSize: 20.0)),
                    color: Colors.amberAccent,
                    onPressed: () {
                      _getUserID().then((String s) {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => RequestConfirm(
                                _deliveryDate, _deliveryRange, args, s));
                      });

                      // Navigator.pushNamed(
                      //   context,
                      //   '/matching',
                      //   arguments: DateAndRange(_deliveryDate, _deliveryRange),
                      // );
                    },
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
