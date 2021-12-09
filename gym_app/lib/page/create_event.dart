import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/create_event/create_event_bloc.dart';
import 'package:gym_app/logic/create_event/create_event_state.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/widget/create_event_widgets/create_event_button.dart';
import 'package:gym_app/widget/create_event_widgets/create_event_input.dart';

class EventCreator extends StatefulWidget{

  EventCreator({Key?key, required this.trainer}) : super(key:key);

  final trainer;

  @override 
  EventCreatorState createState() =>  EventCreatorState(trainer: trainer);
}

class EventCreatorState extends State<EventCreator> {
  final trainer;

  EventCreatorState({required this.trainer});

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
    return BlocProvider(
      create: (context) => CreateEventBloc(repository: const Repository()),
      child: BlocListener<CreateEventBloc, CreateEventState>(
        listener: (context, state) {
          if(state.status == CreateEventStatus.failure) {
            ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: 
                                Text("Event cannot be created")
                              )
                            );
          }else if(state.status == CreateEventStatus.success){
            ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: 
                                Text("Event created")
                              )
                            );
          }
        },
        child: Scaffold(
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
                  children: const [
                    CreateEventInput(inputType: 'name'),
                    SizedBox(height: 12),
                    CreateEventInput(inputType: 'lat'),
                    SizedBox(height: 12),
                    CreateEventInput(inputType: 'long'),
                    SizedBox(height: 12),
                    CreateEventButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
  }
  /*
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
  
  }*/
}

