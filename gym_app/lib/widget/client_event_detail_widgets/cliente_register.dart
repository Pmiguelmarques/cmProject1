import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/client_register/client_register_bloc.dart';
import 'package:gym_app/logic/client_register/client_register_event.dart';
import 'package:gym_app/logic/client_register/client_register_state.dart';

class ClientRegister extends StatelessWidget {

  const ClientRegister({required this.userName, required this.eventName});

  final String userName;
  final String eventName;

  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<ClientRegisterBloc, ClientRegisterState>(
        builder: (context, state){
          return SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
              onPressed: () {
                if(state.isRegistered){
                  context.read<ClientRegisterBloc>().add(ClientUnregistration(userName: userName, eventName: eventName));
                }else{
                  context.read<ClientRegisterBloc>().add(ClientRegistration(userName: userName, eventName: eventName));
                }
              },
              child: const Text("Go to Event", style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)))
            ) 
          );
        },
    );
  }
}

/*
class ClientRegisterState extends State<ClientRegister> {


  @override 
  Widget build(BuildContext context){
    return SizedBox(
    width: 200,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
      onPressed: () async {
        serviceEnabled = await location.serviceEnabled();
        if(!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if(serviceEnabled) return;
        }
        permissionGranted = await location.hasPermission();
        if(permissionGranted == PermissionStatus.denied){
          permissionGranted = await location.requestPermission();
          if(permissionGranted != PermissionStatus.granted) return;
        }
        locationData = await location.getLocation();
        setState(() {
          print(allMarkers.length);
          var newLat = locationData.latitude;
          var newLng = locationData.longitude;
          if(newLat != null && newLng != null){
            LatLng newLocation = LatLng(newLat, newLng);
            if(isVisible){
              isVisible = false;
              buttonText = "Go to Event";
              allMarkers.remove(allMarkers.elementAt(1));
              Boxes.getClient(userPassword).events.remove(Boxes.getEventAt(eventIndex));
              
            }else{
              isVisible = true;
              buttonText = "Cancel";
              allMarkers.add(Marker(
                markerId: const MarkerId('destination'),
                infoWindow: const InfoWindow(title: 'destination'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                position: newLocation
              ));
              Boxes.getClient(userPassword).events.add(Boxes.getEventAt(eventIndex));
            }
          }  
        }
      );
    }, 
    child: Text(buttonText, style: const TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
  ),
)
  }
}



*/