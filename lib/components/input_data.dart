import 'package:app_academia/components/input_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class Inputdata extends StatefulWidget {
  DateTime? dateInit;
  DateTime? dateEnd;
  final Function(DateTime) setdateInit;
  final Function(DateTime) setDateEnd;
  final String plan;
  Inputdata({
    super.key, 
    required this.plan, 
    this.dateInit, 
    this.dateEnd, 
    required this.setdateInit, 
    required this.setDateEnd,
  });

  @override
  State<Inputdata> createState() => _InputdataState();
}

class _InputdataState extends State<Inputdata> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputLabel('Inicio do Plano:'),
        const SizedBox(height: 5,),
        InkWell(
          onTap: () {
            showDatePicker(
              context: context, 
              firstDate: DateTime(2020), 
              lastDate: DateTime.now(),
            ).then((value) {
              setState(() {
                widget.dateInit = value;
                if (widget.plan == 'Semanal') {
                  widget.dateEnd = (Jiffy.parseFromDateTime(widget.dateInit!).add(days: 7)).dateTime;
                } else {
                  widget.dateEnd = (Jiffy.parseFromDateTime(widget.dateInit!).add(months: 1)).dateTime;
                }
                widget.setdateInit(widget.dateInit!);
                widget.setDateEnd(widget.dateEnd!);                     
              });
            });
          },
          child: Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 220, 219, 219),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(width: 5,),
                Text(
                  widget.dateInit == null 
                  ? 'Ex: 10/12/2023'
                  : DateFormat('dd/MM/yyyy').format(widget.dateInit!),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                    color: Color.fromARGB(255, 99, 98, 98)
                  ),
                )              
              ],
            ),
          ),
        ),
        const SizedBox(height: 15,),
        const InputLabel('Válido até:'),
        const SizedBox(height: 5,),
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 220, 219, 219),
            borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_month),
              const SizedBox(width: 5,),
              Text(
                widget.dateEnd == null 
                ? 'Ex: 10/01/2024'
                : DateFormat('dd/MM/yyyy').format(widget.dateEnd!),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: Color.fromARGB(255, 99, 98, 98)
                ),
              )  
            ],
          ),
        ),
      ],
    );
  }
}