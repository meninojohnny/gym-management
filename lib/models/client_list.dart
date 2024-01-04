import 'dart:convert';
import 'dart:math';
import 'package:app_academia/models/client.dart';
import 'package:app_academia/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;

class ClientList with ChangeNotifier {
  List<Client> _clients = [];
  bool _showPendentesOnly = false;
  bool _showAtivosOnly = false;
  bool searching = false;
  String valueSearch = '';
  Client _clientSelected = Client(
    id: '', 
    matricula: '', 
    name: '', 
    genero: '', 
    plano: '', 
    status: '', 
    dateInit: DateTime(1000), 
    dateEnd: DateTime(1000),
  );
  
  Future<void> setClientSelected(String clientId) async {
    int index = _clients.indexWhere((clie) => clie.id == clientId);
    _clientSelected = _clients[index];
    await http.patch(
      Uri.parse('${Constants.CLIENT_SELECTED_URL}.json'),
      body: jsonEncode({'clientSelectedId': clientId})
    );
    
  }

  get clientSelected => _clientSelected;
  
  Future<void> loadClientSelected() async {
    final response = await http.get(Uri.parse('${Constants.CLIENT_SELECTED_URL}.json'));
    String clientSelectedI = jsonDecode(response.body)['clientSelectedId'];
    for (final client in _clients) {
      if (client.id == clientSelectedI) {
        _clientSelected = client;
      }
    }
  }

  List<Client> get clients {
    if (searching) {
      return _clients.where((client) {
        return client.name.toUpperCase().contains(valueSearch.toUpperCase());
      }).toList();
    } else if (_showPendentesOnly) {
      return _clients.where((client) => client.status == 'Pendente').toList();
    } else if (_showAtivosOnly) {
      return _clients.where((client) => client.status == 'Ativo').toList();
    }
    return _clients;
  }

  List<Client> sortClients(List clients) {
    List<String> listNameClients = [];
    List listClientsTemp = clients.where((element) => true).toList();
    for(final client in clients) {
      listNameClients.add(client.name);
    }
    listNameClients.sort();
    List<Client> newListClients = [];
    for (final clientName in listNameClients) {
      for(final client in listClientsTemp) {
        if (client.name == clientName) {
          newListClients.add(client);
          listClientsTemp.remove(client);
        }
      }
    }
    return newListClients;
  }
    
  void showPendentesOnly() {
    _showPendentesOnly = true;
    _showAtivosOnly = false;
    searching = false;
    notifyListeners();
  }

  void showAll() {
    _showPendentesOnly = false;
    _showAtivosOnly = false;
    searching = false;
    notifyListeners();
  }

  void showAtivosOnly() {
    _showPendentesOnly = false;
    _showAtivosOnly = true;
    searching = false;
    notifyListeners();
  }

  List<Client> get clientsPendentes => _clients.where((client) => client.status == 'Pendente').toList();

  int get totalClients => _clients.length;
  
  int get totalClientsPendents => clientsPendentes.length;

  int get totalClientsAtivos => totalClients - totalClientsPendents;
  
  Future<void> addClient(Map data) async {
    String matricula = (Random().nextInt(2000) + 1000).toString();
    final response = await http.post(
      Uri.parse('${Constants.CLIENT_BASE_URL}.json'),
      body: jsonEncode({
        'matricula': matricula,
        'nome': (data['nome'] as String).toUpperCase(),
        'genero': data['genero'],
        'plano': data['plano'],
        'status': data['status'],
        'dataInit': data['dataIni'],
        'dataEnd': data['dataEnd'],
      })
    );
    if (response.statusCode >= 400) {
      throw Exception();
    }
  }

  Future<void> updateClient(Client client) async {
    final response = await http.patch(
      Uri.parse('${Constants.CLIENT_BASE_URL}/${client.id}.json'),
      body: jsonEncode({
        'matricula': client.matricula,
        'nome': client.name.toUpperCase(),
        'genero': client.genero,
        'plano': client.plano,
        'status': client.status,
        'dataInit': client.dateInit.toIso8601String(),
        'dataEnd': client.dateEnd.toIso8601String(),
      })
    );

    if(response.statusCode >= 400) {
      throw Exception();
    } else {
      int index = _clients.indexWhere((clie) => clie.id == client.id);
      _clients[index] = client;
      _clientSelected = client;
    }

    notifyListeners();
  }

  Future<void> loadClients() async {
    _clients.clear();
    final response = await http.get(Uri.parse('${Constants.CLIENT_BASE_URL}.json'));
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((clientId, clientData) {
      _clients.add(Client(
        id: clientId, 
        matricula: clientData['matricula'], 
        name: (clientData['nome'] as String).toUpperCase(), 
        genero: clientData['genero'], 
        plano: clientData['plano'], 
        status: clientData['status'], 
        dateInit: DateTime.parse(clientData['dataInit']), 
        dateEnd: DateTime.parse(clientData['dataEnd']),
      ));
    });
    notifyListeners();
  }

  Future<void> removeClient(Client client) async {
    await http.delete(Uri.parse('${Constants.CLIENT_BASE_URL}/${client.id}.json'));
  }

  Future<void> toggleStatus(Client client) async {
    DateTime current = DateTime.now();
    Client newClient = Client(
      id: client.id,
      matricula: client.matricula,
      name: client.name, 
      genero: client.genero, 
      plano: client.plano, 
      status: 'Ativo', 
      dateInit: current, 
      dateEnd: client.plano == 'Mensal' 
      ? Jiffy.parseFromDateTime(current).add(months: 1).dateTime
      : Jiffy.parseFromDateTime(current).add(days: 7).dateTime,
    );
    await updateClient(newClient).then((value) {
      _clientSelected = newClient;
    });

    notifyListeners();

    return Future.value();
  }

  void getValueSearch(String value) {
    valueSearch = value;
    notifyListeners();
  }

  Future<void> verifyStatusClient() async {
    DateTime current = DateTime.now();
    for (final client in _clients) {
      if (!client.dateEnd.isAfter(current)) {
        await http.patch(
          Uri.parse('${Constants.CLIENT_BASE_URL}/${client.id}.json'),
          body: jsonEncode({'status': 'Pendente'})
        );
      }
    }
  }
}