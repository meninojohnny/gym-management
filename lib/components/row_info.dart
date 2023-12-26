import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  final String label;
  final String info;
  const RowInfo({
    super.key, 
    required this.label, 
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label, 
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8,),
        Text(info.toUpperCase())
      ],
    );
  }
}