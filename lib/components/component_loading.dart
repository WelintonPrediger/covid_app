import 'dart:math';

import 'package:covid19/app_config/app_config_export.dart';
import 'package:flutter/material.dart';

class ComponentLoadingIndicator extends StatefulWidget {
  const ComponentLoadingIndicator({Key? key}) : super(key: key);

  @override
  _ComponentLoadingIndicatorState createState() => _ComponentLoadingIndicatorState();
}

class _ComponentLoadingIndicatorState extends State<ComponentLoadingIndicator> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animationRotation;
  late Animation<double> animationRadiusIn;
  late Animation<double> animationRadiusOut;

  final double initialRadius = 35.0;

  double radius = 0.0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));

    animationRotation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    animationRadiusIn = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: const Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animationRadiusOut = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {

      setState(() {
        if(controller.value >= 0.75 && controller.value <= 1.0){
          radius = animationRadiusIn.value * initialRadius;

        } else if(controller.value >= 0.0 && controller.value <= 0.25){
          radius = animationRadiusOut.value * initialRadius;
        }
      });

    });

    controller.repeat();

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: RotationTransition(
                  turns: animationRotation,
                  child: Stack(
                    children: [
                      const Center(
                          child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(Constant.logo)
                          )
                      ),
                      Transform.translate(
                          offset: Offset(radius * cos(pi/4), radius * sin(pi/4)),
                          child: Dot(radius: 9.0, color: Colors.orange[600]!)),
                      Transform.translate(
                          offset: Offset(radius * cos(2*pi/4), radius * sin(2*pi/4)),
                          child: Dot(radius: 9.0, color: Colors.orange[600]!)),
                      Transform.translate(
                          offset: Offset(radius * cos(3*pi/4), radius * sin(3*pi/4)),
                          child: Dot(radius: 9.0, color: Colors.orange[600]!)),
                      Transform.translate(
                          offset: Offset(radius * cos(4*pi/4), radius * sin(4*pi/4)),
                          child: Dot(radius: 9.0, color: Colors.orange[600]!)),
                      Transform.translate(
                          offset: Offset(radius * cos(5*pi/4), radius * sin(5*pi/4)),
                          child: Dot(radius: 9.0, color: Colors.orange[600]!)),
                      Transform.translate(
                          offset: Offset(radius * cos(6*pi/4), radius * sin(6*pi/4)),
                          child: Dot(radius: 9.0, color: Colors.orange[600]!)),
                      Transform.translate(
                          offset: Offset(radius * cos(7*pi/4), radius * sin(7*pi/4)),
                          child: Dot(radius: 9.0, color: Colors.orange[600]!)),
                      Transform.translate(
                          offset: Offset(radius * cos(8*pi/4), radius * sin(8*pi/4)),
                          child: Dot(radius: 9.0, color: Colors.orange[600]!)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {

  final double radius;
  final Color color;

  const Dot({Key? key, required this.radius, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle
        ),
      ),
    );
  }
}