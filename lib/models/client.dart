class Client {
  final String id;
  final String name;
  final String genero;
  final String plano;
  String status;
  DateTime dateInit;
  DateTime dateEnd;

  Client({
    required this.id, 
    required this.name, 
    required this.genero,
    required this.plano, 
    required this.status,
    required this.dateInit, 
    required this.dateEnd,
  });

}