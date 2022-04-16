import 'dart:async';

import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration fadingDuration;
  final Offset slideBegingOffset;
  final Curve slideCurve;
  const DelayedAnimation({
    Key? key,
    required this.child,
    this.delay = Duration.zero,
    this.fadingDuration = const Duration(milliseconds: 800),
    this.slideBegingOffset = const Offset(0, 0.35),
    this.slideCurve = Curves.fastOutSlowIn,
  }) : super(key: key);

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.fadingDuration,
    );
    _slideAnimation =
        Tween<Offset>(begin: widget.slideBegingOffset, end: Offset.zero)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.slideCurve,
      ),
    );
    _runFadeAnimation();
  }

  _runFadeAnimation() {
    _timer = Timer(widget.delay, () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
