import 'package:app_academia/components/input_label.dart';
import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hinText;
  final TextEditingController controller;
  const InputText({super.key, required this.label, required this.hinText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(label),
        const SizedBox(height: 5,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 220, 219, 219),
            borderRadius: BorderRadius.circular(5)
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinText
            ),
          ),
        )
      ],
    );
  }
}