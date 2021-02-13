import 'package:flutter/material.dart';

class ErrandSelectionRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 160,
        width: double.infinity,
        child: Container(
          color: Colors.grey[100],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 90,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/Delivery',
                        arguments: "Collegetown Food Delivery",
                      );
                    },
                    elevation: 2.0,
                    fillColor: Color(0xffFF8B98),
                    child: Image(
                      image: AssetImage('assets/bowl.png'),
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                ),
                Text(
                  'Getting\nFood',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      )
    ]);
  }
}
