import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _profilePictureAnimation;
  late Animation _contentAnimation;
  late Animation _listAnimation;
  late Animation _fabAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _profilePictureAnimation = Tween(begin: 0.0, end: 50.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.20, curve: Curves.easeOut)));

    _contentAnimation = Tween(begin: 0.0, end: 34.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.20, 0.40, curve: Curves.easeOut)));

// Opacity goes from 0.0 to 1.0
    _listAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.40, 0.75, curve: Curves.easeOut)));

// Fab Size goes from size * 0.0 to size * 1.0
    _fabAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeOut)));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Transform.scale(
          scale: _fabAnimation.value,
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.supervised_user_circle),
              color: Colors.black,
              onPressed: () {},
              iconSize: _profilePictureAnimation.value,
            ),
          ],
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "Good Morning",
                            style: TextStyle(
                                fontSize: _contentAnimation.value,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          const Text(
                            "Here are your plans for today",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Opacity(
                      opacity: _listAnimation.value,
                      child: ListView.builder(
                        itemCount: 40,
                        itemBuilder: (context, position) {
                          return CheckboxListTile(
                            title: Text("This is item $position"),
                            value: true,
                            onChanged: (val) {},
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
