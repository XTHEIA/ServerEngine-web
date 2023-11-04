import 'dart:async';

import 'package:flutter/widgets.dart';

class Slideshow extends StatefulWidget {
  Slideshow({
    required this.children,
    this.intervalMili = 3000,
    this.transitionMili = 300,
    super.key,
  });

  final int intervalMili, transitionMili;
  final List<Widget> children;
  late final int count = children.length;

  @override
  State<Slideshow> createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  late final Timer switchTimer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    switchTimer = Timer.periodic(
      Duration(milliseconds: widget.intervalMili),
      (timer) {
        setState(() {
          currentIndex += 1;
          if (currentIndex >= widget.count) {
            currentIndex = 0;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    switchTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: widget.transitionMili),
      child: widget.children[currentIndex],
    );
  }
}
