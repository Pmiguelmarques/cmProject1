// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:gym_app/page/user_event_details.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:gym_app/model/event.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserHomePage extends StatefulWidget {

  UserHomePage({Key?key, required this.userPassword}) : super(key: key);

  final userPassword;
  
  @override
  UserHomePageState createState() => UserHomePageState(userPassword: userPassword);

}

class UserHomePageState extends State<UserHomePage> {
  final userPassword;

  UserHomePageState({required this.userPassword});

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
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(246, 233, 233,1),
                border: Border.all(
                  color: const Color.fromRGBO(39, 33, 33,1)
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0)
                )
              ),

             
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const CircleAvatar(backgroundImage: NetworkImage("https://www.un.org/sites/un2.un.org/files/user.png"),radius: 100,),
                  const SizedBox(height: 10),
                  Text(Boxes.getClient(userPassword).firstName + " " + Boxes.getClient(userPassword).lastName, style: const TextStyle(color: Color.fromRGBO(225, 100, 40,1)))
                ]
              )
            ),
            const SizedBox(height: 25,),
            Container(
              width: 400,
              height: 50,
              decoration: const BoxDecoration(
                color: const Color.fromRGBO(39, 33, 33,1),
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
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: Boxes.getClient(userPassword).events.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final event = Boxes.getClient(userPassword).events[index];
                  return buildEvent(context, event, index, userPassword);
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildContent(List<Event> events, String userPassword) {
  if(events.isEmpty){
    return const Center(
      child: Text('No events!')
    );
  }else{
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: events.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index){
        final event = events[index];
        return buildEvent(context, event, index, userPassword);
      }
    );
  }
}

Widget buildEvent(BuildContext context, Event event, int index, String userPassword) {
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
        var temp = Boxes.getClient(userPassword).events[index].key;
        
        
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserEventDetails(eventIndex: temp, userPassword: userPassword, fav: true)
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

