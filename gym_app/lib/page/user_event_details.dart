import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:gym_app/widget/map.dart';
import 'package:location/location.dart';


class UserEventDetails extends StatefulWidget {

  const UserEventDetails({
    Key?key,
    required this.eventIndex,
    required this.userPassword,
    required this.fav
  }) : super(key: key);

  final eventIndex;
  final userPassword;
  final fav;

  @override 
  UserEventDetailState createState() => UserEventDetailState(eventIndex: eventIndex, userPassword: userPassword, fav: fav);

}

class UserEventDetailState extends State<UserEventDetails> {

  
  

  final eventIndex;
  final userPassword;
  final fav;

  String buttonText = "Go to Event";

  UserEventDetailState({
    required this.eventIndex,
    required this.userPassword,
    required this.fav
  });

  @override 
  Widget build(BuildContext context) {
    bool isVisible = Boxes.isFav(Boxes.getClient(userPassword), Boxes.getEventAt(eventIndex));
    Location location = new Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    bool isListenLocation = false;
    bool isGetLocation = false;
    double dataToShow = 0.0;

    if(allMarkers.length > 2){
      allMarkers.remove(allMarkers.elementAt(2));
    }

    final eventInfo = Boxes.getEvents().get(eventIndex);
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
      body: Center(
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
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(39, 33, 33,1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0)
                        )
                      ),
                      height: 100,
                      width: 200,
                      child: Column(  
                        children: [
                          const SizedBox(height: 20),
                          Text("${eventInfo!.name}", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(225, 100, 40,1))),
                          const SizedBox(height: 20),
                          Text("Hosted by: ${eventInfo.teacher}",style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(246, 233, 233,1)),)
                        ]
                      ),
                    )
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(39, 33, 33,1)
                      )
                    ),
                    child: MapScreen(eventIndex: eventIndex),
                    height: 200,
                    width: 300,
                  ),
                  SizedBox(
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
              ]
            )
          ),
          
          const SizedBox(height: 25),
          if(isVisible)
            SizedBox(
              
              child: 
                QrImage(
                  backgroundColor: Colors.white,
                  data:eventInfo.name
                ),
              height: 200,
              width: 200
            )
          ]
        )
      )
    );
  }

  void getLocation() {

  }
}



