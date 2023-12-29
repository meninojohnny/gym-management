import 'dart:math';
import 'package:app_academia/data/bd_clients.dart';
import 'package:app_academia/models/client.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class ClientList with ChangeNotifier {
  final List<Client> _clients = DUMMY_CLIENTS;
  bool _showPendentesOnly = false;
  bool _showAtivosOnly = false;
  bool searching = false;
  String valueSearch = '';

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

  List<Client> get clientsPendentes {
    return _clients.where((client) => client.status == 'Pendente').toList();
  }

  int get totalClients {
    return _clients.length;
  }

  int get totalClientsPendents {
    return clientsPendentes.length;
  }

  int get totalClientsAtivos {
    return totalClients - totalClientsPendents;
  }
  
  void addClient(Map data) {
    bool hasId = data['id'] != null;
    Client client = Client(
      id: hasId ? data['id'] : (Random().nextInt(2000) + 1000).toString(), 
      name: data['nome'], 
      genero: data['genero'], 
      plano: data['plano'], 
      status: 'Ativo', 
      dateInit: data['dataIni'], 
      dateEnd: data['dataFim'],
    );

    print(client.dateInit);

    if (hasId) {
      updateClient(client);
    } else {
      _clients.add(client);
    }
    notifyListeners();
  }

  void removeClient(Client client) {
    _clients.remove(client);
    notifyListeners();
  }

  void updateClient(Client client) {
    int index = _clients.indexWhere((Client e) => e.id == client.id);
    _clients[index] = client;
    notifyListeners();
  }

  void toggleStatus(Client client) {
    client.status = 'Ativo';
    DateTime current = DateTime.now();
    client.dateInit = current;
    client.dateEnd = Jiffy(current).add(months: 1).dateTime;
    notifyListeners();
  }

  void getValueSearch(String value) {
    valueSearch = value;
    notifyListeners();
  }

  void verifyStatusClient() {
    DateTime current = DateTime.now();
    for (final client in _clients) {
      if (!client.dateEnd.isAfter(current)) {
        client.status = 'Pendente';
      } else {
        client.status = 'Ativo';
      }
    }
  }
}