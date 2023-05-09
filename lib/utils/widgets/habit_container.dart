// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_/constants/const.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class ItemContainer extends StatelessWidget {
  String habit;
  void Function()? onTap;

  ItemContainer({
    Key? key,
    required this.habit,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 80,
            left: 10,
            child: GradientBall(
              colors: [
                Color.fromARGB(255, 118, 223, 242),
                Colors.amber,
              ],
            ),
          ),
          const Positioned(
            top: 20,
            right: 10,
            child: GradientBall(
              size: Size.square(200),
              colors: [Colors.blue, Colors.purple],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlurryContainer(
              color: Colors.white.withOpacity(0.10),
              // color: Colors.white.withOpacity(0.15),
              blur: 8,
              elevation: 6,
              height: 80,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Checkbox(value: true, onChanged: (p0) {}),
                        Center(
                          child: Text(
                            habit,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientBall extends StatelessWidget {
  final List<Color> colors;
  final Size size;
  const GradientBall({
    Key? key,
    required this.colors,
    this.size = const Size.square(150),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
    );
  }
}
