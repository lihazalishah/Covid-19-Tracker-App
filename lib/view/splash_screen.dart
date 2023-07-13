import 'dart:async';
import 'dart:math' as math;

import 'package:covidapp/view/world_stat.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = // animation
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // after 3 sec
      // navigation
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WorldStatScreen(), // go to statscreen
          ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            // for animation perform
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: _controller.value * 2.5 * math.pi, // degree of animation
                child: child, // above 2.5 is for speed of rotation
              );
            },
            child: Container(
              // container pass in above child in transform
              width: MediaQuery.sizeOf(context).width * 0.6,
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: const Center(
                  child: Image(image: NetworkImage('assets/images/virus.png'))),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .05,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Covid-19\nTracker App',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
