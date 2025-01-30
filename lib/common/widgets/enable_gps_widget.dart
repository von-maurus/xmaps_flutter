import 'package:flutter/material.dart';

class EnableGPSWidget extends StatelessWidget {
  const EnableGPSWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Must enable GPS access',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
    );
  }
}