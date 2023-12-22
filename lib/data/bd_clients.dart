import 'package:app_academia/models/client.dart';

class BdClients {
  final List<Client> _clients = [
  Client(
    id: '1000', 
    name: 'João Vitor Silva', 
    plano: 'Mensal', 
    status: 'Ativo', 
    dateInit: '10/12/2023', 
    dateEnd: '10/01/2024',
  ),
  Client(
    id: '1001', 
    name: 'Malu Magalhães', 
    plano: 'Mensal', 
    status: 'Ativo', 
    dateInit: '20/12/2023', 
    dateEnd: '20/01/2024',
  ),
  Client(
    id: '1002', 
    name: 'Evelyn Cardozo', 
    plano: 'Semanal', 
    status: 'Pendente', 
    dateInit: '07/12/2023', 
    dateEnd: '14/12/2023',
  ),
  Client(
    id: '1003', 
    name: 'Matheus Rosa', 
    plano: 'Mensal', 
    status: 'Ativo', 
    dateInit: '15/12/2023', 
    dateEnd: '15/01/2024',
  ),
  Client(
    id: '1000', 
    name: 'Guilherme Santos', 
    plano: 'Mensal', 
    status: 'Ativo', 
    dateInit: '10/12/2023', 
    dateEnd: '10/01/2024',
  ),
  Client(
    id: '1001', 
    name: 'Julia Freitas', 
    plano: 'Mensal', 
    status: 'Ativo', 
    dateInit: '20/12/2023', 
    dateEnd: '20/01/2024',
  ),
  Client(
    id: '1002', 
    name: 'David Silva', 
    plano: 'Semanal', 
    status: 'Pendente', 
    dateInit: '07/12/2023', 
    dateEnd: '14/12/2023',
  ),
  Client(
    id: '1003', 
    name: 'Bruno Silva', 
    plano: 'Mensal', 
    status: 'Ativo', 
    dateInit: '15/12/2023', 
    dateEnd: '15/01/2024',
  ),
  Client(
    id: '1000', 
    name: 'Helena Sousa', 
    plano: 'Mensal', 
    status: 'Ativo', 
    dateInit: '10/12/2023', 
    dateEnd: '10/01/2024',
  ),
  Client(
    id: '1001', 
    name: 'Lorena Martins', 
    plano: 'Mensal', 
    status: 'Ativo', 
    dateInit: '20/12/2023', 
    dateEnd: '20/01/2024',
  ),
  Client(
    id: '1002', 
    name: 'Gabrielle Morais', 
    plano: 'Semanal', 
    status: 'Pendente', 
    dateInit: '07/12/2023', 
    dateEnd: '14/12/2023',
  ),
  Client(
    id: '1003', 
    name: 'Edu Veras', 
    plano: 'Mensal', 
    status: 'Ativo', 
    dateInit: '15/12/2023', 
    dateEnd: '15/01/2024',
  ),
];

  List<Client> get clients {
    return _clients;
  }

  int get totalAlunosAtivos {
    int total = 0;
    clients.map((clie) {
      if (clie.status == 'Ativo') {
        total++;
      }
    }).toList();
    return total;
  }

  List<Client> get clientsPendentes {
    return clients.where((client) {
      return client.status == 'Pendente';
    }).toList();
  }
}

