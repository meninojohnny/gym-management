import 'package:app_academia/components/card_item_client.dart';
import 'package:app_academia/components/card_item_page.dart';
import 'package:app_academia/components/card_label.dart';
import 'package:app_academia/components/custom_app_bar.dart';
import 'package:app_academia/models/client_list.dart';
import 'package:app_academia/screens/client_detail_page.dart';
import 'package:app_academia/screens/client_screen.dart';
import 'package:app_academia/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClientList(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 41, 213, 18),
          cardColor: const Color.fromARGB(255, 199, 251, 13),
          fontFamily: 'Lato'
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.HOME_PAGE,
        routes: {
          AppRoutes.HOME_PAGE: (_) => const HomePage(),
          AppRoutes.CLIENT_SCREEN: (_) => const ClientScreen(),
          AppRoutes.CLIENT_DETAIL: (_) => ClientDetailPage()
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClientList>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 158, 159, 157),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
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
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const CardLabel(),
            Column(
              children: provider.clientsPendentes.map((client) {
                return CardItemCLient(client: client);
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}