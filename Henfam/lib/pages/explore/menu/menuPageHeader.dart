import 'package:Henfam/bloc/basket/basket_bloc.dart';
import 'package:Henfam/models/restaurant.dart';
import 'package:Henfam/pages/explore/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'menu.dart';

class MenuPageHeader extends SliverPersistentHeaderDelegate {
  MenuPageHeader({
    this.minExtent,
    @required this.maxExtent,
    @required this.restaurant,
  });
  final double minExtent;
  final double maxExtent;
  final Restaurant restaurant;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(fit: StackFit.expand, children: [
      Image(
        image: AssetImage(restaurant.bigImagePath),
        fit: BoxFit.cover,
      ),
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
        colors: [Colors.transparent, Colors.black54],
        stops: [0.5, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        tileMode: TileMode.repeated,
      ))),
      Positioned(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
        child: Text(restaurant.name,
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
            )),
      ),
      Positioned(
        top: 30.0,
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
          onPressed: () {
            BlocProvider.of<BasketBloc>(context).add(BasketReset());
            Menu.order = [];
            Menu.onPressed = () {};
            Navigator.pop(context);
          },
        ),
      ),
    ]);
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  // @override
  // FloatingHeaderSnapConfiguration get snapConfiguration => null;
}
