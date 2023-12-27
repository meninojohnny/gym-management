import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  final String label;
  const InputLabel(this.label, {super.key, });

  @override
  Widget build(BuildContext context) {
    return Text(
      label, 
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}