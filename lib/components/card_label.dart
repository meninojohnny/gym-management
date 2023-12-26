import 'package:flutter/material.dart';

class CardLabel extends StatelessWidget {
  const CardLabel({super.key});

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.sizeOf(context).width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        color: Color.fromARGB(255, 30, 29, 29),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: 
        (MediaQuery.sizeOf(context).width < 500)
        ? [
          SizedBox(width: mediaQuery * .33, child: Text('Nome', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
          const SizedBox(width: 70, child: Text('Plano', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
          const SizedBox(width: 70, child: Text('Status', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
        ]
        : [
          const SizedBox(width: 80, child: Text('Matrícula', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
          SizedBox(width: mediaQuery * .25, child: Text('Nome', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
          const SizedBox(width: 70, child: Text('Plano', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
          const SizedBox(width: 70, child: Text('Status', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }
}