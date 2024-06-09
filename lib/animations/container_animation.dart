import 'package:flutter/material.dart';

class Goodanimation extends StatefulWidget {
  const Goodanimation({
    super.key,
    required this.delay,
    required this.child,
  });

  final double delay;
  final Widget child;

  @override
  State<Goodanimation> createState() => _GoodanimationState();
}

class _GoodanimationState extends State<Goodanimation>
    with TickerProviderStateMixin {
  late Animation animation1;
  late Animation animation2;
  late Animation textanimation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: (120 * widget.delay).round()));

    animation1 = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut))
      ..addListener(() {
        setState(() {});
      });

    animation2 = Tween(
      begin: 150 * widget.delay,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut))
      ..addListener(() {
        setState(() {});
      });

    textanimation = Tween(
      begin: 0.0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    dispose() {
      controller.dispose();
      super.dispose();
    }

    return Transform.scale(
      scale: animation1.value,
      child: Transform.translate(
        offset: Offset(0, widget.delay),
        child: Opacity(
          opacity: animation1.value,
          child: widget.child,
        ),
      ),
    );
  }
}