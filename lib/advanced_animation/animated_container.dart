import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerWidget> createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _containerAnimation;
  late Animation _positionAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _positionAnimation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.center)
            .animate(CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.0, 0.7, curve: Curves.easeInOut)));
    _containerAnimation = Tween(begin: 40.0, end: 200.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 1.0, curve: Curves.bounceOut)));

    _controller.forward();
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Align(
              alignment: _positionAnimation.value,
              child: Container(
                height: _containerAnimation.value,
                width: _containerAnimation.value,
                color: Colors.blue,
              ),
            );
          }),
    );
  }
}
