
import 'package:app_academia/components/card_item_client.dart';
import 'package:app_academia/components/card_item_page.dart';
import 'package:app_academia/components/card_label.dart';
import 'package:app_academia/components/custom_app_bar.dart';
import 'package:app_academia/screens/client_screen.dart';
import 'package:app_academia/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:app_academia/data/bd_clients.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final BdClients _bdClients = BdClients();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.HOME_PAGE,
      routes: {
        AppRoutes.HOME_PAGE: (_) => HomePage(bdClients: _bdClients,),
        AppRoutes.CLIENT_SCREEN: (_) => ClientScreen(bdClients: _bdClients,),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final BdClients bdClients;
  const HomePage({super.key, required this.bdClients});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: CustomAppBar(title: 'Tela inicial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.5,
              ),
              children: const [
                CardItemPage(
                  icon: Icons.person,
                  title: 'Clientes', 
                  route: AppRoutes.CLIENT_SCREEN,
                ),
                CardItemPage(
                  icon: Icons.payment,
                  title: 'Pagamentos', 
                  route: AppRoutes.HOME_PAGE,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Text(
                'Alunos pendentes:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const CardLabel(),
            Column(
              children: bdClients.clientsPendentes.map((client) {
                return CardItemCLient(client: client);
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}