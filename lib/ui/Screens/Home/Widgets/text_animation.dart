import 'package:flutter/material.dart';
import 'dart:async';

import 'package:e_commerce/main.dart';
import 'package:sizer/sizer.dart';

class AnimateText extends StatefulWidget {
  final String firstText;
  final String secondsText;

  const AnimateText({
    super.key,
    required this.firstText,
    required this.secondsText,
  });

  @override
  _AnimatedTextSwitcherState createState() => _AnimatedTextSwitcherState();
}

class _AnimatedTextSwitcherState extends State<AnimateText> {
  int currentIndex = 0;
  late List<String> texts;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    texts = [widget.firstText, widget.secondsText];
    _startAnimationLoop();
  }

  void _startAnimationLoop() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      setState(() {
        currentIndex = (currentIndex + 1) % texts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final outAnimation = Tween<Offset>(
              begin: Offset(0, 1),
              end: const Offset(0, 0),
            ).animate(animation);
            final inAnimation = Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset(0, 0),
            ).animate(animation);
            return SlideTransition(
              position: child.key == ValueKey(texts[currentIndex])
                  ? inAnimation
                  : outAnimation,
              child: child,
            );
          },
          child: Text(
            texts[currentIndex],
            key: ValueKey<String>(texts[currentIndex]),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14.sp,
              // fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
