import 'package:flutter/material.dart';

import 'package:nui/keys.dart';

class AnimatedLogo extends StatefulWidget {
  AnimatedLogo() : super(key: AppKeys.animatedLogo);

  @override
  State<StatefulWidget> createState() {
    return AnimatedLogoState();
  }
}

class AnimatedLogoState extends State<AnimatedLogo> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  static final sizeTween = Tween<double>(begin: 80, end: 90);

  @override
  void initState() {
    super.initState();

    this.controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    this.animation = CurvedAnimation(parent: this.controller, curve: Curves.easeIn);
    this.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        this.controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        this.controller.forward();
      }
    });

    this.controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: this.animation,
      builder: (context, child) {
        return CircleAvatar(
          backgroundColor: Colors.white,
          radius: 70.0,
          child: Image(
            width: sizeTween.evaluate(animation),
            height: sizeTween.evaluate(animation),
            image: AssetImage('assets/logo.png'),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }
}
