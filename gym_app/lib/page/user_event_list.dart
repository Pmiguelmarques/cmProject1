import 'package:flutter/material.dart';
import 'package:gym_app/page/user_event_details.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:gym_app/model/event.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class UserEventList extends StatefulWidget {

  const UserEventList({
    Key?key,
    required this.userPassword
  }) : super(key: key);

  final userPassword;

  @override
  UserEventListState createState() => UserEventListState(userPassword: userPassword);

}

class UserEventListState extends State<UserEventList> {
  
  UserEventListState({required this.userPassword});
  
  final userPassword;
  
  @override 
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(39, 33, 33,1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(225, 100, 40,1)
        ),
      ),
      backgroundColor: const Color.fromRGBO(54, 51, 51,1),
      body: ValueListenableBuilder<Box<Event>>(
        valueListenable: Boxes.getEvents().listenable(),
        builder: (context, box, _) {
          final events = box.values.toList().cast<Event>();
          return buildContent(events, userPassword);
        }
      )
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
      itemBuilder: (BuildContext context, int index){
        final event = events[index];
        return buildEvent(context, event, index, userPassword);
      }
    );
  }
}

Widget buildEvent(BuildContext context, Event event, int index, String userPassword) {
  return Container(
    height: 75,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(246, 233, 233,1),
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      border: Border.all(
        color: const Color.fromRGBO(39, 33, 33,1) 
      )
    ),
    child: InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserEventDetails(eventIndex: index, userPassword: userPassword, fav: false)
        ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            event.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
          )
        ],
      ),
    ) 
    
  );
}

/*
Card(
      color: Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserEventDetails(eventIndex: event.key)
          ));
        },
        child: Row(
          children:  [
            SizedBox(height: 20),
            Text(
            event.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
          )]
        ),
      ),
    )
*/