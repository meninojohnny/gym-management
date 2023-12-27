import 'package:app_academia/components/row_info.dart';
import 'package:app_academia/models/client.dart';
import 'package:app_academia/models/client_list.dart';
import 'package:app_academia/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientDetailPage extends StatelessWidget {
   const ClientDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Client client = ModalRoute.of(context)!.settings.arguments as Client;
    // Client client = DUMMY_CLIENTS[0];
    final provider = Provider.of<ClientList>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 158, 159, 157),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Container(alignment: Alignment.center,
          child: Text(
            client.name.toUpperCase(), 
            style: const TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.CLIENT_SCREEN);
          },
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 0,
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.FORM_EDIT_CLIENT, arguments: client);
                },
                child: const Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 5,),
                    Text('Editar perfil'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 5,),
                    Text('Ecluir perfil'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                provider.removeClient(client);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
          color: const Color.fromARGB(255, 225, 217, 217),
          borderRadius: BorderRadius.circular(5)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  client.genero == 'Masculino' 
                  ? Icons.person 
                  : Icons.person_2, 
                  size: 150,
                ),
              ),
              const SizedBox(height: 10,),
              RowInfo(label: 'Nome:', info: client.name),
              const SizedBox(height: 5,),
              RowInfo(label: 'Matrícula:', info: client.id),
              const SizedBox(height: 5,),
              RowInfo(label: 'Gênero:', info: client.genero),
              const SizedBox(height: 5,),
              RowInfo(label: 'Plano:', info: client.plano),
              const SizedBox(height: 5,),
              Row(
                children: [
                  RowInfo(label: 'Status:', info: client.status),
                  const SizedBox(width: 20,),
                  if (client.status == 'Pendente')
                  ElevatedButton(
                    onPressed: () {
                      provider.toggleStatus(client);
                    }, 
                    child: const Text(
                      'Renovar Plano', 
                      style: TextStyle(color: Color.fromARGB(255, 15, 119, 20)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              RowInfo(label: 'Data de inicio:', info: client.dateInit),
              const SizedBox(height: 5,),
              RowInfo(label: 'Validade:', info: client.dateEnd),
            ],
          ),
        ),
      ),
    );
  }
}