import 'package:flutter/material.dart';
import 'package:gym_app/page/create_event.dart';

class TeacherEventButton extends StatelessWidget {

  const TeacherEventButton({required this.username});

  final username;

  @override 
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventCreator(trainer: username)
          ));
        },  
        child: const Text('Add Event', style: const TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
      ),
    );
  }
}