import 'package:flutter/material.dart';

class CardLabel extends StatelessWidget {
  const CardLabel({super.key});

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.sizeOf(context).width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: 
        (MediaQuery.sizeOf(context).width < 500)
        ? [
          SizedBox(width: mediaQuery * .33, child: Text('Nome', style: TextStyle(fontWeight: FontWeight.bold),),),
          const SizedBox(width: 70, child: Text('Plano', style: TextStyle(fontWeight: FontWeight.bold),)),
          const SizedBox(width: 70, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold),)),
        ]
        : [
          const SizedBox(width: 80, child: Text('Matrícula', style: TextStyle(fontWeight: FontWeight.bold),)),
          SizedBox(width: mediaQuery * .25, child: Text('Nome', style: TextStyle(fontWeight: FontWeight.bold),),),
          const SizedBox(width: 70, child: Text('Plano', style: TextStyle(fontWeight: FontWeight.bold),)),
          const SizedBox(width: 70, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }
}