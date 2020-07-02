import 'package:flutter/material.dart';

class ShowCircularProgress extends StatelessWidget {
  final isLoading;

  ShowCircularProgress(this.isLoading);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
