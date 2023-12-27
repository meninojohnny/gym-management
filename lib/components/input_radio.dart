import 'package:app_academia/components/input_label.dart';
import 'package:flutter/material.dart';

class InputRadio extends StatefulWidget {
  final String label;
  final List listValues;
  final Function(String) onChanged;
  String valueSelected = '';
  InputRadio({super.key, this.valueSelected = '', required this.label, required this.listValues, required this.onChanged});

  @override
  State<InputRadio> createState() => _InputRadioState();
}

class _InputRadioState extends State<InputRadio> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(widget.label),
        Column(
          children: widget.listValues.map((plano) {
          return RadioListTile(
            dense: true,
            title: Text(plano),
            value: plano, 
            groupValue: widget.valueSelected,
            selected: widget.valueSelected == plano,
            onChanged: (value) {
              setState(() {
                widget.onChanged(value);
                widget.valueSelected = value;
              });
            },
          );
        }).toList()
        )
      ],
    );
  }
}