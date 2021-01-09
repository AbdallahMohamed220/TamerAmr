//library dots_indicator;

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

typedef void OnTap(double position);

class CustomDotsIndicator extends StatelessWidget {
  final int dotsCount;
  final double position;
  final DotsDecorator decorator;
  final Axis axis;
  final bool reversed;
  final OnTap onTap;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;

  const CustomDotsIndicator({
    Key key,
    @required this.dotsCount,
    this.position = 0.0,
    this.decorator = const DotsDecorator(),
    this.axis = Axis.horizontal,
    this.reversed = false,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.onTap,
  })  : assert(dotsCount != null && dotsCount > 0),
        assert(position != null && position >= 0),
        assert(decorator != null),
        assert(
          position < dotsCount,
          "Position must be inferior than dotsCount",
        ),
        super(key: key);

  Widget _buildDot(int index) {
    final state = min(1.0, (position - index).abs());

    final size = Size.lerp(decorator.activeSize, decorator.size, state);
    final color = Color.lerp(decorator.activeColor, decorator.color, state);

    final dot = Container(
      width: size.width,
      height: size.height,
      margin: decorator.spacing,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        //borderRadius: BorderRadius.circular(25),
      ),
      // decoration: ShapeDecoration(
      //   color: color,
      //   shape: shape,
      // ),
    );
    return onTap == null
        ? dot
        : InkWell(
            customBorder: const CircleBorder(),
            onTap: () => onTap(index.toDouble()),
            child: dot,
          );
  }

  @override
  Widget build(BuildContext context) {
    final dotsList = List<Widget>.generate(dotsCount, _buildDot);
    final dots = reversed == true ? dotsList.reversed.toList() : dotsList;

    return axis == Axis.vertical
        ? Column(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: dots,
          )
        : Row(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: dots,
          );
  }
}

const Size kDefaultSize = Size.square(9.0);
const EdgeInsets kDefaultSpacing = EdgeInsets.all(6.0);
const ShapeBorder kDefaultShape = CircleBorder();

class DotsDecorator {
  /// Inactive dot color
  ///
  /// @Default `Colors.grey`
  final Color color;

  /// Active dot color
  ///
  /// @Default `Colors.lightBlue`
  final Color activeColor;

  /// Inactive dot size
  ///
  /// @Default `Size.square(9.0)`
  final Size size;

  /// Active dot size
  ///
  /// @Default `Size.square(9.0)`
  final Size activeSize;

  /// Inactive dot shape
  ///
  /// @Default `CircleBorder()`
  final ShapeBorder shape;

  /// Active dot shape
  ///
  /// @Default `CircleBorder()`
  final ShapeBorder activeShape;

  /// Spacing between dots
  ///
  /// @Default `EdgeInsets.all(6.0)`
  final EdgeInsets spacing;

  const DotsDecorator({
    this.color = Colors.grey,
    this.activeColor = Colors.lightBlue,
    this.size = kDefaultSize,
    this.activeSize = kDefaultSize,
    this.shape = kDefaultShape,
    this.activeShape = kDefaultShape,
    this.spacing = kDefaultSpacing,
  })  : assert(color != null),
        assert(activeColor != null),
        assert(size != null),
        assert(activeSize != null),
        assert(shape != null),
        assert(activeShape != null),
        assert(spacing != null);
}
