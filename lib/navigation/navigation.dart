import 'package:flutter/material.dart';

import '../presentation/screens/home_screen.dart';

class ApplicationNavigation {
  final BuildContext context;

  const ApplicationNavigation(this.context);

  void navigateToHomeScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
