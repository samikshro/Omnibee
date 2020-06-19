import 'package:Henfam/models/errandModel.dart';
import 'package:Henfam/pages/explore/errandDropDown.dart';
import 'package:flutter/material.dart';

class ErrandsNearby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: ErrandModel.list.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return ErrandDropDown(ErrandModel.list[index]["caption"],
              ErrandModel.list[index]["errands"]);
        });
  }
}
