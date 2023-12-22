import 'package:app_academia/models/client.dart';
import 'package:flutter/material.dart';

class CardItemCLient extends StatelessWidget {

  final Client client;

  const CardItemCLient({super.key, required this.client,});

  Color get colorStatus {
    return client.status == 'Ativo' ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
  double mediaQuery = MediaQuery.sizeOf(context).width;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: 
          mediaQuery < 500
          ? [
            SizedBox(width: 180, child: Text(client.name)),
            SizedBox(width: 70, child: Text(client.plano)),
            SizedBox(
              width: 70, 
              child: Text(
                client.status,
                style: TextStyle(
                  color: colorStatus
                )
              ),
            ),
          ]
          : [
            SizedBox(width: 80, child: Text(client.id)),
            SizedBox(width: mediaQuery * .25, child: Text(client.name.toUpperCase())),
            SizedBox(width: 70, child: Text(client.plano)),
            SizedBox(
              width: 70, 
              child: Text(
                client.status,
                style: TextStyle(
                  color: colorStatus
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}