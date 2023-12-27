import 'dart:math';

import 'package:app_academia/components/input_radio.dart';
import 'package:app_academia/components/input_text.dart';
import 'package:app_academia/models/client.dart';
import 'package:app_academia/models/client_list.dart';
import 'package:app_academia/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormRegisterClientPage extends StatefulWidget {
  const FormRegisterClientPage({super.key});

  @override
  State<FormRegisterClientPage> createState() => _FormRegisterClientPageState();
}

class _FormRegisterClientPageState extends State<FormRegisterClientPage> {
  List planos = ['Mensal', 'Semanal'];
  List generos = ['Masculino', 'Feminino', 'Outro'];

  TextEditingController nomeController = TextEditingController();
  TextEditingController dataIni = TextEditingController();
  TextEditingController dataFim = TextEditingController();
  String? genderSelected;
  String? planSelected;

  void setGenderSelected(String value) {
    genderSelected = value;
  }

  void setPlanSelected(String value) {
    planSelected = value;
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClientList>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 158, 159, 157),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            'Cadastrar cliente', 
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.CLIENT_SCREEN);
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
                  hinText: 'Ex: Joao Vitor Silva',
                  controller: nomeController,
                ),
                const SizedBox(height: 15,),
                InputRadio(
                  label: 'Gênero:', 
                  listValues: generos,
                  onChanged: setGenderSelected,
                ),
                const SizedBox(height: 15,),
                InputRadio(
                  label: 'Plano:', 
                  listValues: planos,
                  onChanged: setPlanSelected,
                ),
                const SizedBox(height: 15,),
                InputText(
                  label: 'Inicio do Plano:', 
                  hinText: 'Ex: 10/12/2023',
                  controller: dataIni,
                ),
                const SizedBox(height: 15,),
                InputText(
                  label: 'válido até:', 
                  hinText: 'Ex: 10/12/2023',
                  controller: dataFim,
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        provider.addClient(
                          Client(
                            id: (1000 + Random().nextInt(1000)).toString(), 
                            name: nomeController.text, 
                            genero: genderSelected!, 
                            plano: planSelected!, 
                            status: 'Ativo', 
                            dateInit: dataIni.text, 
                            dateEnd: dataFim.text
                          ),
                        );
                        Navigator.of(context).pushReplacementNamed(AppRoutes.CLIENT_SCREEN);
                      }, 
                      child: const Text('Cadastrar'),
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