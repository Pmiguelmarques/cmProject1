import 'package:gym_app/data/model/event.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/page/user_event_details.dart';

class EventListItem extends StatelessWidget {
  const EventListItem({Key? key, required this.event, required this.username}) : super(key: key);

  final Event event;
  final username; 

  @override 
  Widget build(BuildContext context){
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
            builder: (context) => UserEventDetails(event: event.name, username: username)
            )
          );
        },
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            event.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
          )
        ],
        )
      )
    );
  }
}
/*
Material(
      child: ListTile(
        leading: Text(event.teacher),
        title: Text(event.name),
        isThreeLine: true,
        subtitle: Text(event.data),
        dense: true
      )
    );
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
*/