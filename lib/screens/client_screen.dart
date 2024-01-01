import 'package:app_academia/components/card_label.dart';
import 'package:app_academia/components/client_item_list.dart';
import 'package:app_academia/components/custom_app_bar.dart';
import 'package:app_academia/models/client.dart';
import 'package:app_academia/models/client_list.dart';
import 'package:app_academia/utils/app_routes.dart';
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
  late bool searching;
  bool isLoading = true;

  void renderView() {
    setState(() {  
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ClientList>(context, listen: false).loadClients().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ClientList>(context);
    clients = provider.clients;
    totalAlunos = provider.totalClients;
    totalAlunosAtivos = provider.totalClientsAtivos;
    totalAlunosPendentes = provider.totalClientsPendents;
    searching = provider.searching;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 158, 159, 157),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: CustomAppBar(title: 'Tela de clientes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_PAGE);
            provider.showAll();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                provider.searching = !provider.searching;
                searching = !searching;
              });
            }, 
            icon: Icon(searching ? Icons.search_off : Icons.search),
          ),
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
          },
        )
        ],
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
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

                  MediaQuery.sizeOf(context).width < 500 
                  ? Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(228, 255, 255, 255),
                      shape: BoxShape.circle
                    ),
                    child: IconButton(
                      color: const Color.fromARGB(255, 30, 29, 29),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(AppRoutes.FORM_REGISTER_CLIENT);
                      }, 
                      icon: const Icon(Icons.person_add)
                    ),
                  )
                  : ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.FORM_REGISTER_CLIENT);
                    }, 
                    child: const Text('Adicionar cliente', style: TextStyle(color: Colors.black),))
                ],
              ),
              if (searching)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 226, 223, 223),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ex: Joao Silva'
                  ),
                  onChanged: (String value) {
                    provider.getValueSearch(value);
                  },
                ),
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