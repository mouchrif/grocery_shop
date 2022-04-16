import 'dart:math' as math;
import 'package:flutter/material.dart';

class DelayedFlipCardItemsAnimation extends StatefulWidget {
  final int? delay;
  final Widget child;
  const DelayedFlipCardItemsAnimation(
      {Key? key, required this.child, this.delay})
      : super(key: key);

  @override
  State<DelayedFlipCardItemsAnimation> createState() =>
      _DelayedFlipCardItemsAnimationState();
}

class _DelayedFlipCardItemsAnimationState
    extends State<DelayedFlipCardItemsAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    ));
    Future.delayed(const Duration(milliseconds: 1000), () =>
      Future.delayed(
        Duration(milliseconds: widget.delay!*80),
        flipAnimationForward
    ));
  }

  void flipAnimationForward() {
    if (_animController.isDismissed) {
      _animController.forward();
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return AnimatedOpacity(
          opacity: _animController.value,
          duration: const Duration(milliseconds: 100),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(-1 / 2 * math.pi * _animation.value),
            child: child,
          ),
        );
      },
    );
  }
}
