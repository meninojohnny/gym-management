import 'package:app_academia/components/input_label.dart';
import 'package:app_academia/components/input_radio.dart';
import 'package:app_academia/components/input_text.dart';
import 'package:app_academia/models/client_list.dart';
import 'package:app_academia/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class FormRegisterClientPage extends StatefulWidget {
  const FormRegisterClientPage({super.key});

  @override
  State<FormRegisterClientPage> createState() => _FormRegisterClientPageState();
}

class _FormRegisterClientPageState extends State<FormRegisterClientPage> {
  List planos = ['Mensal', 'Semanal'];
  List generos = ['Masculino', 'Feminino', 'Outro'];
  final Map<String,Object> _formData = {};

  TextEditingController nomeController = TextEditingController();
  String? genderSelected;
  String? planSelected;
  DateTime? dateInit;
  DateTime? dateEnd;

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
            Navigator.of(context).pop();
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
                const SizedBox(height: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputLabel('Inicio do Plano:'),
                    const SizedBox(height: 5,),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context, 
                          firstDate: DateTime(2020), 
                          lastDate: DateTime.now(),
                        ).then((value) {
                          setState(() {
                            dateInit = value;
                            dateEnd = (Jiffy(dateInit).add(months: 1)).dateTime;
                          });
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 220, 219, 219),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 5,),
                            Text(
                              dateInit == null 
                              ? 'Ex: 10/12/2023'
                              : DateFormat('dd/MM/yyyy').format(dateInit!),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: Color.fromARGB(255, 99, 98, 98)
                              ),
                            )
                            
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputLabel('Válido até:'),
                    const SizedBox(height: 5,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 220, 219, 219),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month),
                          const SizedBox(width: 5,),
                          Text(
                            dateEnd == null 
                            ? 'Ex: 10/01/2024'
                            : DateFormat('dd/MM/yyyy').format(dateEnd!),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Color.fromARGB(255, 99, 98, 98)
                            ),
                          )
                          
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _formData['nome'] = nomeController.text;
                        _formData['dataFim'] = dateEnd!;
                        _formData['dataIni'] = dateInit!;
                        _formData['genero'] = genderSelected!;
                        _formData['plano'] = planSelected!;
                        provider.addClient(_formData);
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