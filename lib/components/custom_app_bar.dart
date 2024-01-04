import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(title),
    );
    
  }
}