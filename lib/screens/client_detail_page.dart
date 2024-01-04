import 'package:app_academia/components/custom_app_bar.dart';
import 'package:app_academia/components/row_info.dart';
import 'package:app_academia/models/client.dart';
import 'package:app_academia/models/client_list.dart';
import 'package:app_academia/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClientDetailPage extends StatefulWidget {
  const ClientDetailPage({super.key});

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  late Client client;
  bool isLoading = true;
  bool actionLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ClientList>(context, listen: false).loadClients().then((value) {
      Provider.of<ClientList>(context, listen: false).verifyStatusClient().then((value)  {
        Provider.of<ClientList>(context, listen: false).loadClientSelected().then((value) {
          setState(() {isLoading = false;});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClientList>(context);
    client = provider.clientSelected;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 158, 159, 157),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: CustomAppBar(title: client.name.toUpperCase()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 0,
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.FORM_EDIT_CLIENT);
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
                showDialog(
                  context: context, 
                  builder: (_) {
                    return AlertDialog(
                      content: Text(
                        'Deseja excluir ${client.name}?',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          child: const Text('Não'),
                        ),
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                          provider.removeClient(client).then((value) {
                            setState(() {});
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Erro ao conluir a ação. Tente novamente')));
                          });
                        }, child: const Text('Sim')),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator(),) 
      : SingleChildScrollView(
        child: Padding(
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
                RowInfo(label: 'Matrícula:', info: client.matricula),
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
                    actionLoading ? const CircularProgressIndicator() : ElevatedButton(
                      onPressed: () {
                        setState(() {actionLoading = true;});
                        provider.toggleStatus(client).then((value) { 
                          setState(() {actionLoading = false;});
                          // Navigator.of(context).pushReplacementNamed(AppRoutes.CLIENT_DETAIL);
                        }).catchError((error) {
                            setState(() {actionLoading = false;});
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text('Erro ao conluir a ação. Tente novamente')));
                          });;
                      }, 
                      child: MediaQuery.sizeOf(context).width <= 360 
                      ? Icon(Icons.repeat)
                      : Text(
                        'Renovar Plano', 
                        style: TextStyle(color: Color.fromARGB(255, 15, 119, 20)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                RowInfo(label: 'Data de inicio:', info: DateFormat('dd/MM/yyy').format(client.dateInit).toString()),
                const SizedBox(height: 5,),
                RowInfo(label: 'Validade:', info: DateFormat('dd/MM/yyy').format(client.dateEnd)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}