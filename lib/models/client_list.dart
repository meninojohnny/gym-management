import 'package:app_academia/data/bd_clients.dart';
import 'package:app_academia/models/client.dart';
import 'package:flutter/material.dart';

class ClientList with ChangeNotifier {
  List<Client> _clients = DUMMY_CLIENTS;
  bool _showPendentesOnly = false;
  bool _showAtivosOnly = false;

  List<Client> get clients {
    if (_showPendentesOnly) {
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
    _showAtivosOnly = false;
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
}