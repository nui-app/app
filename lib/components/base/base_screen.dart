import 'package:flutter/material.dart';

import 'package:nui/keys.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final String title;

  BaseScreen({
    @required this.child,
    @required this.title,
  }) : super(key: AppKeys.baseScreen);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Image.asset('assets/pattern.jpg'),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(this.title),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            color: Colors.white,
            child: this.child,
          ),
        ),
      ],
    );
  }
}
