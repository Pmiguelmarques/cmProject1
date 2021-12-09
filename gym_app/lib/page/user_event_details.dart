import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/client_invitation/client_invitation_bloc.dart';
import 'package:gym_app/logic/client_register/client_register_bloc.dart';
import 'package:gym_app/logic/event_map/event_map_bloc.dart';
import 'package:gym_app/logic/event_map/event_map_event.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:gym_app/widget/client_event_detail_widgets/client_event_details.dart';
import 'package:gym_app/widget/client_event_detail_widgets/client_invitation.dart';
import 'package:gym_app/widget/client_event_detail_widgets/cliente_register.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:gym_app/widget/map.dart';
import 'package:location/location.dart';


class UserEventDetails extends StatefulWidget {

  const UserEventDetails({
    Key?key,
    required this.event,
    required this.username,
  }) : super(key: key);

  final event;
  final username;

  @override 
  UserEventDetailState createState() => UserEventDetailState(event: event, username: username);

}

class UserEventDetailState extends State<UserEventDetails> {

  String buttonText = "Go to Event";

  UserEventDetailState({
    required this.event,
    required this.username
  });

  final event;
  final username;
  final clientRegister = ClientRegisterBloc(repository: const Repository());


  @override 
  Widget build(BuildContext context) {
    //bool isVisible = Boxes.isFav(Boxes.getClient(userPassword), Boxes.getEventAt(eventIndex));
    Location location = new Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    bool isListenLocation = false;
    bool isGetLocation = false;
    double dataToShow = 0.0;

    //if(allMarkers.length > 2){
    //  allMarkers.remove(allMarkers.elementAt(2));
    //}

    //final eventInfo = Boxes.getEvents().get(eventIndex);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
        centerTitle: false,
        backgroundColor: const Color.fromRGBO(39, 33, 33,1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(225, 100, 40,1)
        ),
      ),
      backgroundColor: const Color.fromRGBO(54, 51, 51,1),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ClientRegisterBloc>(
            create: (context) => clientRegister
          ),
          BlocProvider<ClientInvitationBloc>(
            create: (context) => ClientInvitationBloc(clientRegistration: clientRegister)
          ),
          BlocProvider<EventMapBloc>(
            create: (context) => EventMapBloc(repository: const Repository())..add(MapInitEvent(eventName: event))
          )
        ], 
        child: Center(
          child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 325,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(39, 33, 33,1)
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                color: const Color.fromRGBO(246, 233, 233,1)
              ),
              child: Column(
                  children: [
                    ClientEventDetails(eventname: event),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(39, 33, 33,1)
                        )
                      ),
                      child: MapScreen(),
                      height: 200,
                      width: 300,
                    ),
                    ClientRegister(userName: username, eventName: event)
                ]
              )
            ),
            
            const SizedBox(height: 25),
            ClientInvitation(eventName: event)
            ]
          )
        )
      ) 
    );
  }

  void getLocation() {

  }
}



