class Client {
  final String id;
  final String matricula;
  final String name;
  final String genero;
  final String plano;
  final String status;
  final DateTime dateInit;
  final DateTime dateEnd;

  Client({
    required this.id,
    required this.matricula,
    required this.name, 
    required this.genero,
    required this.plano, 
    required this.status,
    required this.dateInit,
    required this.dateEnd,
  });

}