import 'dart:io';

import 'package:cgpa/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 3),
            builder: (context, value, child) {
              return Center(
                child: Opacity(
                  opacity: value,
                  child: Lottie.asset(
                    "images/result.json",
                    controller: _controller,
                    onLoaded: (composition) {
                      _controller.duration = composition.duration;
                      _controller.forward().whenComplete(() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      });
                    },
                    height: 50 + value * 100,
                    width: 50 + value * 100,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
          TweenAnimationBuilder(
            tween: Tween(begin: 2.0, end: 22.0),
            duration: Duration(seconds: 3),
            builder: (context, value, child) {
              return Text("Hi there!", style: TextStyle(fontSize: value));
            },
          ),
        ],
      ),
    );
  }
}
