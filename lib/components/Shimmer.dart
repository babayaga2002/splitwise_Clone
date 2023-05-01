import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmer extends StatelessWidget {
  late final double height;
  late final int count;
  // ignore: prefer_const_constructors_in_immutables
  ListShimmer({
    Key? key,
    this.height = 100,
    this.count = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Container sample = Container(
      height: height,
      decoration:
      BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(25)),
    );
    return Shimmer.fromColors(
        period: const Duration(seconds: 1),
        baseColor: Color.fromRGBO(47, 48, 51, 1),
        highlightColor: Color.fromRGBO(68, 71, 79, 1),
        child: SizedBox(
            height:count * (height + 20),
            child: ListView.builder(
                itemCount: count,
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: sample,
                ))));
  }
}
