import 'package:app_academia/components/card_item_client.dart';
import 'package:app_academia/models/client.dart';
import 'package:flutter/material.dart';

class ClientItemList extends StatelessWidget {
  final List<Client> clients;
  const ClientItemList({super.key, required this.clients});

  // @override
  // Widget build(BuildContext context) {
  //   return ListView(
  //     children: clients.map((client) {
  //       return CardItemCLient(client: client,);
  //     }).toList(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...clients.map((client) {
        return CardItemCLient(client: client);
      })],
    );
  }
}