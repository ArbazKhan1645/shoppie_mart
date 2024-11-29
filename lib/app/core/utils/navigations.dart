import 'package:flutter/material.dart';

void navigateToNextSelection(BuildContext context, Widget child) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => child,
    ),
  );
}
