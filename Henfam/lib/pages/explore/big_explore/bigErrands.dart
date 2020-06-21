import 'package:flutter/material.dart';

class BigErrands extends StatefulWidget{
  @override
  _BigErrandsState createState() => _BigErrandsState();
}

class _BigErrandsState extends State<BigErrands> {

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     physics: NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: ErrandModel.list.length,
    //     itemBuilder: (BuildContext ctxt, int index) {
    //       return ErrandDropDown(ErrandModel.list[index]["caption"],
    //           ErrandModel.list[index]["errands"]);
    //     });
  }
}