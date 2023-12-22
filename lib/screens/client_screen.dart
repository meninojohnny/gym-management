import 'package:app_academia/components/card_item_client.dart';
import 'package:app_academia/components/card_label.dart';
import 'package:app_academia/components/client_item_list.dart';
import 'package:app_academia/components/custom_app_bar.dart';
import 'package:app_academia/data/bd_clients.dart';
import 'package:flutter/material.dart';

class ClientScreen extends StatefulWidget {
  final BdClients bdClients;
  const ClientScreen({super.key, required this.bdClients});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {

  late int totalAlunos;
  late int totalAlunosAtivos;
  late int totalAlunosPendentes;

  @override
  void initState() {
    super.initState();
    totalAlunos = widget.bdClients.clients.length;
    totalAlunosAtivos = widget.bdClients.totalAlunosAtivos;
    totalAlunosPendentes = totalAlunos - totalAlunosAtivos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: CustomAppBar(title: 'Tela de clientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total de Alunos: $totalAlunos'),
              const SizedBox(height: 3,),
              Text('Total de Alunos Ativos: $totalAlunosAtivos'),
              const SizedBox(height: 3,),
              Text('Total de Alunos Pendentes: $totalAlunosPendentes'),
              const SizedBox(height: 10,),
              const CardLabel(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .65,
                child: ClientItemList(clients: widget.bdClients.clients),
              ),
            ],
          ),
        ),
      ),
    );
  }
}