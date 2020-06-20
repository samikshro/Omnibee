import 'package:Henfam/models/menuModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

class MenuPageHeader extends SliverPersistentHeaderDelegate {
  MenuPageHeader({
    this.minExtent,
    @required this.maxExtent,
    @required this.restaurant,
  });
  final double minExtent;
  final double maxExtent;
  final MenuModel restaurant;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(fit: StackFit.expand, children: [
      restaurant.bigPhoto,
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
        child: Text(restaurant.restName,
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
            )),
      )
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
