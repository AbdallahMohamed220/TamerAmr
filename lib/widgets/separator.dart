import 'package:flutter/material.dart';

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 6, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 30.0;
        final dashHeight = height;
        var dashCount = (boxWidth / (2 * dashWidth)).floor();
        dashCount = dashCount * 2;
        return Flex(
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: dashHeight,
              padding: EdgeInsets.only(right: 2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
