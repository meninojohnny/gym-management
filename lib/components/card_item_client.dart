import 'package:app_academia/models/client.dart';
import 'package:app_academia/models/client_list.dart';
import 'package:app_academia/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardItemCLient extends StatelessWidget {

  final Client client;

  const CardItemCLient({super.key, required this.client,});

  Color get colorStatus {
    return client.status == 'Ativo' ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
  double mediaQuery = MediaQuery.sizeOf(context).width;

    return InkWell(
      onTap: () {
        Provider.of<ClientList>(context, listen: false).setClientSelected(client.id);
        Navigator.of(context).pushNamed(
          AppRoutes.CLIENT_DETAIL,
          arguments: client
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 2.5, top: 2.5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(228, 255, 255, 255),
          borderRadius: BorderRadius.circular(2)        
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: 
            mediaQuery < 500
            ? [
              SizedBox(width: mediaQuery * .33, child: Text(client.name)),
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
              SizedBox(width: 80, child: Text(client.matricula)),
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
      ),
    );
  }
}