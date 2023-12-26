import 'package:app_academia/data/bd_clients.dart';
import 'package:app_academia/models/client.dart';
import 'package:flutter/material.dart';

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
    notifyListeners();
  }

  void showAll() {
    _showPendentesOnly = false;
    _showAtivosOnly = false;
    notifyListeners();
  }

  void showAtivosOnly() {
    _showPendentesOnly = false;
    _showAtivosOnly = true;
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
  
  void addClient(Client client) {
    _clients.add(client);
  }

  void removeClient(Client client) {
    _clients.remove(client);
    notifyListeners();
  }

  void toggleStatus(Client client) {
    client.status = 'Ativo';
    notifyListeners();
  }

  void getValueSearch(String value) {
    valueSearch = value;
    notifyListeners();
  }
}