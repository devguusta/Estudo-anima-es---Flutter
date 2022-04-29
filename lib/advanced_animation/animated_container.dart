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
  List list = List.generate(15, (index) => index);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _positionAnimation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.center)
            .animate(CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.0, 0.4, curve: Curves.easeInOut)));
    _containerAnimation = Tween(begin: 70.0, end: 120.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 0.6, curve: Curves.easeInOut)));

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
            return GridView.count(
              childAspectRatio: 1,
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: list
                  .map(
                    (e) => Align(
                      alignment: _positionAnimation.value,
                      child: Container(
                        height: _containerAnimation.value,
                        width: _containerAnimation.value,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.black.withOpacity(0.8),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black87,
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          }),
    );
  }
}
