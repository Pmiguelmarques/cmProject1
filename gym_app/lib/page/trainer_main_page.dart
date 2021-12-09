import 'package:flutter/material.dart';
import 'package:gym_app/page/create_event.dart';

import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/page/trainer_event_details.dart';
import 'package:gym_app/widget/teacher_page/teacher_event_button.dart';
import 'package:gym_app/widget/teacher_page/teacher_events.dart';
import 'package:gym_app/widget/teacher_page/teacher_info.dart';
import 'package:hive/hive.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TrainerMainPage extends StatefulWidget {
  
  TrainerMainPage({Key?key, required this.trainer}) : super(key : key);

  final trainer;

  @override 
  TrainerMainPageState createState() => TrainerMainPageState(trainer: trainer);
}

class TrainerMainPageState extends State<TrainerMainPage> {
  final trainer;

  TrainerMainPageState({required this.trainer});

  @override 
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: const Color.fromRGBO(39, 33, 33,1)
      ),
      backgroundColor: const Color.fromRGBO(54, 51, 51,1),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 25),
            TeacherInfo(username: trainer),
            const SizedBox(height: 25,),
            Container(
              width: 400,
              height: 50,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(39, 33, 33,1),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: const Center(
                  child: Text(
                    "Your Events", 
                    style: TextStyle(color: Color.fromRGBO(225, 100, 40,1), 
                    fontWeight: FontWeight.bold),
                  ),
                )
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: 200.0,
              child: TeacherEvents(username: trainer),
            ),
            TeacherEventButton(username: trainer)
          ],
        ),
      ),
    );

    
  }
}


/*
SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EventCreator(trainerPassword: trainerPassword)
                  ));
                },  
                child: const Text('Add Event', style: const TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
              ),
            ),


Widget buildContent(List<Event> events) {
  if(events.isEmpty){
    return const Center(
      child: Text('No events!'),
    );
  }else{
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: events.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index){
        final event = events[index];
        return buildEvent(context, event, index);
      }
    );
  }
}

Widget buildEvent(BuildContext context, Event event, int index) {
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
          builder: (context) => TrainerEventDetails(eventName: )
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
}*/