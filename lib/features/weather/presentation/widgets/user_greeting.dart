import 'package:flutter/material.dart';

class UserGreeting extends StatelessWidget {
  final String name;

  const UserGreeting({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;

        return Text(
          'Welcome, $name!',
          style: TextStyle(
            fontSize: isSmallScreen ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
