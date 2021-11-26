import 'package:flutter/material.dart';
import 'package:gym_app/utils/event_list.dart';

class EventViewer extends StatefulWidget {

  EventViewerState createState() => EventViewerState();
}

class EventViewerState extends State<EventViewer> {

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView.builder(
        itemCount: createdEvents.length,
        itemBuilder: (context, index) => EventListItem(index)
      )
    );
  }
}

class EventListItem extends StatelessWidget {
  final int index;
  
  EventListItem(this.index);

  @override 
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Card(
            elevation: 5,
            child: Row(
              children: <Widget>[
                Container(
                  height: 150, 
                  width: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)
                    ),        
                  ),
                ),
                Container( 
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        createdEvents[index].name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}