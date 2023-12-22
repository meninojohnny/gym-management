import 'package:app_academia/utils/app_routes.dart';
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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(icon, size: 50, color: Colors.white,),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}