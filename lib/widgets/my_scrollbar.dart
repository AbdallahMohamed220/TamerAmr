import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

class MyScrollbar extends StatefulWidget {
  const MyScrollbar({
    Key key,
    @required this.child,
    this.controller,
    this.isAlwaysShown = false,
  })  : assert(!isAlwaysShown || controller != null,
            'When isAlwaysShown is true, must pass a controller that is attached to a scroll view'),
        super(key: key);

  final Widget child;

  final ScrollController controller;

  final bool isAlwaysShown;

  @override
  _MyScrollbarState createState() => _MyScrollbarState();
}

class _MyScrollbarState extends State<MyScrollbar>
    with TickerProviderStateMixin {
  ScrollbarPainter _materialPainter;
  TextDirection _textDirection;
  Color _themeColor;
  bool _useCupertinoScrollbar;
  AnimationController _fadeoutAnimationController;
  Animation<double> _fadeoutOpacityAnimation;
  Timer _fadeoutTimer;

  @override
  void initState() {
    super.initState();
    _fadeoutAnimationController = AnimationController(
      vsync: this,
      duration: _kScrollbarFadeDuration,
    );
    _fadeoutOpacityAnimation = CurvedAnimation(
      parent: _fadeoutAnimationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert((() {
      _useCupertinoScrollbar = null;
      return true;
    })());
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        _fadeoutTimer?.cancel();
        _fadeoutTimer = null;
        _fadeoutAnimationController.reset();
        _useCupertinoScrollbar = true;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        _themeColor = theme.accentColor;
        _textDirection = Directionality.of(context);
        _materialPainter = _buildMaterialScrollbarPainter();
        _useCupertinoScrollbar = false;
        _triggerScrollbar();
        break;
    }
    assert(_useCupertinoScrollbar != null);
  }

  @override
  void didUpdateWidget(MyScrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAlwaysShown != oldWidget.isAlwaysShown) {
      if (widget.isAlwaysShown == false) {
        _fadeoutAnimationController.reverse();
      } else {
        _triggerScrollbar();
        _fadeoutAnimationController.animateTo(1.0);
      }
    }
  }

  void _triggerScrollbar() {
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      if (widget.isAlwaysShown) {
        _fadeoutTimer?.cancel();
        widget.controller.position.didUpdateScrollPositionBy(0);
      }
    });
  }

  ScrollbarPainter _buildMaterialScrollbarPainter() {
    return ScrollbarPainter(
      color: _themeColor,
      textDirection: _textDirection,
      thickness: 15,
      fadeoutOpacityAnimation: _fadeoutOpacityAnimation,
      padding: EdgeInsets.only(right: 3),
      radius: Radius.circular(30),
      mainAxisMargin: 30,
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    if (metrics.maxScrollExtent <= metrics.minScrollExtent) {
      return false;
    }

    if (!_useCupertinoScrollbar &&
        (notification is ScrollUpdateNotification ||
            notification is OverscrollNotification)) {
      if (_fadeoutAnimationController.status != AnimationStatus.forward) {
        _fadeoutAnimationController.forward();
      }

      _materialPainter.update(
        notification.metrics,
        notification.metrics.axisDirection,
      );
      if (!widget.isAlwaysShown) {
        _fadeoutTimer?.cancel();
        _fadeoutTimer = Timer(_kScrollbarTimeToFade, () {
          _fadeoutAnimationController.reverse();
          _fadeoutTimer = null;
        });
      }
    }
    return false;
  }

  @override
  void dispose() {
    _fadeoutAnimationController.dispose();
    _fadeoutTimer?.cancel();
    _materialPainter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_useCupertinoScrollbar) {
      return CupertinoScrollbar(
        child: widget.child,
        isAlwaysShown: widget.isAlwaysShown,
        controller: widget.controller,
      );
    }
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: RepaintBoundary(
        child: CustomPaint(
          foregroundPainter: _materialPainter,
          child: RepaintBoundary(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
