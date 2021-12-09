import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/page/trainer_event_details.dart';

class TeacherEventItem extends StatelessWidget {

  const TeacherEventItem({required this.event});

  final event;

  @override 
  Widget build(BuildContext context) {
    return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(246, 233, 233,1),
      borderRadius: const BorderRadius.only(
        bottomLeft : Radius.circular(30.0),
        bottomRight: Radius.circular(30.0)
      ),
      border: Border.all(
        color: const Color.fromRGBO(39, 33, 33,1)
      )
    ),
    child: InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TrainerEventDetails(eventName: event.name)
        ));
      },
      child: Column(
        children: [
          Container(
            height: 20,
            color: const Color.fromRGBO(39, 33, 33,1),
          ),
          const SizedBox(height: 30),
          Text(
            event.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
          )
        ],
      ),
    )
  );
  }
}