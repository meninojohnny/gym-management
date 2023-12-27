import 'package:app_academia/components/input_radio.dart';
import 'package:app_academia/components/input_text.dart';
import 'package:app_academia/models/client.dart';
import 'package:app_academia/models/client_list.dart';
import 'package:app_academia/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormEditClientPage extends StatefulWidget {
  const FormEditClientPage({super.key});

  @override
  State<FormEditClientPage> createState() => _FormEditClientPage();
}

class _FormEditClientPage extends State<FormEditClientPage> {
  List planos = ['Mensal', 'Semanal'];
  List generos = ['Masculino', 'Feminino', 'Outro'];
  late Client client;

  @override
  void initState() {
    super.initState();
    
  }

  TextEditingController nomeController = TextEditingController();
  TextEditingController dataIni = TextEditingController();
  TextEditingController dataFim = TextEditingController();
  String genderSelected = '';
  String planSelected = '';

  void setGenderSelected(String value) {
    genderSelected = value;
  }

  void setPlanSelected(String value) {
    planSelected = value;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClientList>(context);
    client = ModalRoute.of(context)!.settings.arguments as Client;
    nomeController.text = client.name;
    dataIni.text = client.dateInit;
    dataFim.text = client.dateEnd;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 158, 159, 157),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            'Editar cliente', 
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            provider.showAll();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [                                  
                InputText(
                  label: 'Nome:', 
                  hinText: nomeController.text,
                  controller: nomeController,
                ),
                const SizedBox(height: 15,),
                InputRadio(
                  label: 'Gênero:', 
                  listValues: generos,
                  valueSelected: client.genero,
                  onChanged: setGenderSelected,
                ),
                const SizedBox(height: 15,),
                InputRadio(
                  label: 'Plano:', 
                  listValues: planos,
                  valueSelected: client.plano,
                  onChanged: setPlanSelected,
                ),
                const SizedBox(height: 15,),
                InputText(
                  label: 'Inicio do Plano:', 
                  hinText: dataIni.text,
                  controller: dataIni,
                ),
                const SizedBox(height: 15,),
                InputText(
                  label: 'válido até:', 
                  hinText: dataFim.text,
                  controller: dataFim,
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        provider.updateClient(client, Client(
                          id: client.id, 
                          name: nomeController.text, 
                          genero: genderSelected != '' ? genderSelected : client.genero, 
                          plano: planSelected != '' ? planSelected : client.plano, 
                          status: client.status, 
                          dateInit: dataIni.text, 
                          dateEnd: dataFim.text,
                        ));
                        Navigator.of(context).pushNamed(AppRoutes.CLIENT_SCREEN);
                      }, 
                      child: const Text('Atualizar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}