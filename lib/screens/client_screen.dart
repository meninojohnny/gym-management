import 'package:app_academia/components/card_label.dart';
import 'package:app_academia/components/client_item_list.dart';
import 'package:app_academia/components/custom_app_bar.dart';
import 'package:app_academia/models/client.dart';
import 'package:app_academia/models/client_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

enum FilterAlunos {
  pendentes,
  ativos,
  all
}

class _ClientScreenState extends State<ClientScreen> {
  late List<Client> clients;
  late int totalAlunos;
  late int totalAlunosAtivos;
  late int totalAlunosPendentes;

  void renderView() {
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ClientList>(context);
    clients = provider.clients;
    totalAlunos = provider.totalClients;
    totalAlunosAtivos = provider.totalClientsAtivos;
    totalAlunosPendentes = provider.totalClientsPendents;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 158, 159, 157),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: CustomAppBar(title: 'Tela de clientes'),
        actions: [
          PopupMenuButton(itemBuilder: (_) => const [
            PopupMenuItem(
              value: FilterAlunos.pendentes,
              child: Text('Mostrar pendentes'),
            ),
            PopupMenuItem(
              value: FilterAlunos.ativos,
              child: Text('Mostrar ativos'),
            ),
            PopupMenuItem(
              value: FilterAlunos.all,
              child: Text('Mostrar todos'),
            )
          ],
          onSelected: (FilterAlunos value) {
            if (value == FilterAlunos.pendentes) {
              provider.showPendentesOnly();
            } else if (value == FilterAlunos.ativos) {
              provider.showAtivosOnly();
            } else {
              provider.showAll();
            }
            renderView();
          },
        )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(115, 0, 0, 0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total de Alunos: $totalAlunos', style: const TextStyle(color: Colors.white),),
                        const SizedBox(height: 3,),
                        Text('Total de Alunos Ativos: $totalAlunosAtivos', style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 3,),
                        Text('Total de Alunos Pendentes: $totalAlunosPendentes', style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {}, 
                    child: const Text('Adicionar cliente', style: TextStyle(color: Colors.black),))
                ],
              ),             
              const CardLabel(),
              SizedBox(
                child: ClientItemList(clients: clients),
              ),
            ],
          ),
        ),
      ),
    );
  }
}