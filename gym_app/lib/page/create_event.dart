import 'package:flutter/material.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:gym_app/model/event.dart';

class EventCreator extends StatefulWidget{

  EventCreator({Key?key, required this.trainerPassword}) : super(key:key);

  final trainerPassword;

  @override 
  EventCreatorState createState() =>  EventCreatorState(trainerPassword: trainerPassword);
}

class EventCreatorState extends State<EventCreator> {
  final trainerPassword;

  EventCreatorState({required this.trainerPassword});

  final nameController = TextEditingController();
  final teacherController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  final dataController = TextEditingController();
  final maxCapacityController = TextEditingController();

  final List<Event> events = [];

  String eventName = '';
  String lat = '';
  String lng = '';

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new Event', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(39, 33, 33,1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(225, 100, 40,1)
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(54, 51, 51,1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          Center(
            child: Column(
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f1f5),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      eventName = value;
                    }),
                    decoration: const InputDecoration(
                      hintText: 'Events name',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f1f5),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      lat = value;
                    }),
                    decoration: const InputDecoration(
                      hintText: 'Latitude',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f1f5),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      lng = value;
                    }),
                    decoration: const InputDecoration(
                      hintText: 'Longitude',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
                    onPressed: () {
                      if(lat != "" && lng != "" && eventName != ""){
                          addTransaction(eventName, double.parse(lat), double.parse(lng));
                      }
                    }, 
                    child: const Text('Create Event', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)))
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future addTransaction(String name, double lat, double long) async {
  
    final event = Event()
    ..name = name
    ..teacher = Boxes.getClient(trainerPassword).firstName + " " + Boxes.getClient(trainerPassword).lastName
    ..lat = lat
    ..long = long
    ..data = "event${name}" 
    ..maxCapacity = 1;

    final box = Boxes.getEvents();
    box.add(event);
    

  }
}

