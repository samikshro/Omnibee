import 'package:flutter/material.dart';

class ShowLogo extends StatelessWidget {
  final isLoading;

  ShowLogo(this.isLoading);

  @override
  Widget build(BuildContext context) {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.asset('assets/beelogo.png', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
