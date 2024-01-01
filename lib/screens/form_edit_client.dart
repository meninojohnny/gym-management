import 'package:app_academia/components/input_data.dart';
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
  bool isLoading = true;
  List planos = ['Mensal', 'Semanal'];
  List generos = ['Masculino', 'Feminino', 'Outro'];
  late Client client;

  TextEditingController nomeController = TextEditingController();
  TextEditingController dataIni = TextEditingController();
  TextEditingController dataFim = TextEditingController();
  String genderSelected = '';
  String planSelected = '';
  DateTime? dateInit;
  DateTime? dateEnd;

  void setGenderSelected(String value) {
    genderSelected = value;
  }

  void setPlanSelected(String value) {
    planSelected = value;
  }

  void setDateInit(DateTime value) {
    dateInit = value;
  }

  void setDateEnd(DateTime value) {
    dateEnd = value;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ClientList>(context, listen: false).loadClients().then((value) {
      Provider.of<ClientList>(context, listen: false).loadClients().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClientList>(context);
    client = provider.clientSelected;
    nomeController.text = client.name;
    dateInit = client.dateInit;
    dateEnd = client.dateEnd;
    planSelected = client.plano;
    genderSelected = client.genero;
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
            Navigator.of(context).pushReplacementNamed(AppRoutes.CLIENT_DETAIL);
            provider.showAll();
          },
        ),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
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
                        
                        provider.updateClient(Client(
                          id: client.id, 
                          matricula: client.matricula, 
                          name: nomeController.text, 
                          genero: genderSelected, 
                          plano: planSelected, 
                          status: client.status, 
                          dateInit: dateInit!, 
                          dateEnd: dateEnd!,
                        ));

                        Navigator.of(context).pushReplacementNamed(AppRoutes.CLIENT_DETAIL);
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