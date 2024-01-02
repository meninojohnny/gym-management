import 'package:app_academia/components/input_data.dart';
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
  String genderSelected = '';
  String planSelected = '';
  DateTime? dateInit;
  DateTime? dateEnd;

  void setGenderSelected(String value) {
    genderSelected = value;
  }

  void setPlanSelected(String value) {
    planSelected = value;
    replaceDate();
    setState(() {});
  }

  void replaceDate() {
    if(dateEnd != null) {
      if (planSelected == 'Semanal') {
        dateEnd = Jiffy.parseFromDateTime(dateInit!).add(days: 7).dateTime;
      } else {
        dateEnd = Jiffy.parseFromDateTime(dateInit!).add(months: 1).dateTime;
      }
    }
  }

   void setDateInit(DateTime value) {
    dateInit = value;
  }

  void setDateEnd(DateTime value) {
    dateEnd = value;
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
            Navigator.of(context).pushReplacementNamed(AppRoutes.CLIENT_SCREEN);
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
                  hinText: 'Ex: Joao Silva',
                  controller: nomeController,
                ),
                const SizedBox(height: 15,),
                InputRadio(
                  label: 'Gênero:',
                  valueSelected: genderSelected,
                  listValues: generos,
                  onChanged: setGenderSelected,
                ),
                const SizedBox(height: 15,),
                InputRadio(
                  label: 'Plano:',
                  valueSelected: planSelected,
                  listValues: planos,
                  onChanged: setPlanSelected,
                ),
                const SizedBox(height: 15,),
                Inputdata(
                  plan: planSelected,
                  dateInit: dateInit,
                  dateEnd: dateEnd,
                  setdateInit: setDateInit,
                  setDateEnd: setDateEnd,
                ),    
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _formData['nome'] = nomeController.text;
                        _formData['dataEnd'] = dateEnd!.toIso8601String();
                        _formData['status'] = 'Ativo';
                        _formData['dataIni'] = dateInit!.toIso8601String();
                        _formData['genero'] = genderSelected;
                        _formData['plano'] = planSelected;
                        provider.addClient(_formData).then((value) {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.CLIENT_SCREEN);
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Erro ao conluir a ação. Tente novamente')));
                        });
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