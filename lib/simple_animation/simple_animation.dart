import 'package:flutter/material.dart';

class SimpleAnimationPage extends StatefulWidget {
  const SimpleAnimationPage({Key? key}) : super(key: key);

  @override
  State<SimpleAnimationPage> createState() => _SimpleAnimationPageState();
}

class _SimpleAnimationPageState extends State<SimpleAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation sizeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller);
    sizeAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animations"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(
          child: Container(
            height: sizeAnimation.value,
            width: sizeAnimation.value,
            color: colorAnimation.value,
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
