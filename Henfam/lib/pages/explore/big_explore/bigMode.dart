import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bigCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BigMode extends StatefulWidget {
  @override
  _BigModeState createState() => _BigModeState();
}

class _BigModeState extends State<BigMode> {
  Timestamp tiempo = Timestamp.now();

  bool _allRunsAccepted(documents) {
    for (int i = 0; i < documents.length; i++) {
      if (documents[i]['user_id']['is_accepted'] == false) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Run Errand'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Flexible(child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderStateLoadSuccess) {
                  List<Order> runnableDeliveries =
                      state.getRunnableDeliveries();

                  if (runnableDeliveries.length == 0) {
                    return Center(
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          'No errands are requested in your area now. Please check back later!',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: runnableDeliveries.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BigCard(
                            context,
                            order: runnableDeliveries[index],
                          );
                        });
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )

                /*StreamBuilder(
                  stream: Firestore.instance
                      .collection('orders')
                      .where("user_id.expiration_time",
                          isGreaterThanOrEqualTo: new DateTime.now())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (_allRunsAccepted(snapshot.data.documents)) {
                      return Center(
                        child: SizedBox(
                          width: 300,
                          child: Text(
                            'No errands are requested in your area now. Please check back later!',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BigCard(context,
                              document: snapshot.data.documents[index]);
                        });
                  }),*/
                ),
          ]),
    );
  }
}
