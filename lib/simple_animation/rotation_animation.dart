import 'package:flutter/material.dart';

class RotationAnimation extends StatefulWidget {
  const RotationAnimation({Key? key}) : super(key: key);

  @override
  State<RotationAnimation> createState() => _RotationAnimationState();
}

class _RotationAnimationState extends State<RotationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation rotationAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    rotationAnimation = Tween(begin: 0.0, end: 3.14).animate(controller);

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Animations"),
        ),
        body: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Center(
                child: Transform.rotate(
                  angle: rotationAnimation.value,
                  child: Container(
                    color: Colors.blue,
                    width: 200.0,
                    height: 200.0,
                  ),
                ),
              );
            })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
