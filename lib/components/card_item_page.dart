import 'package:flutter/material.dart';
class CardItemPage extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;
  const CardItemPage({super.key, required this.title, required this.route, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        elevation: 5,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color:const Color.fromARGB(255, 36, 36, 36),),
              const SizedBox(height: 10,),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromARGB(255, 36, 36, 36),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}