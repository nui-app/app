import 'package:flutter/material.dart';
import 'package:nui/components/base/base_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Home',
      child: Center(
        child: Text('Test'),
      ),
    );
  }
}
