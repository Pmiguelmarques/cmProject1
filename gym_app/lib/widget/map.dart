import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/logic/event_map/event_map_bloc.dart';
import 'package:gym_app/logic/event_map/event_map_state.dart';
import 'package:gym_app/widget/boxes.dart';

/*
class MapScreen extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<EventMapBloc, EventMapState>(
      builder: (context, state){
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(state.lat, state.lng),
            zoom: 14.4748
          ),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            Completer().complete(controller);
          },
        );
      }
    );
  }
}
*/


class MapScreen extends StatefulWidget {

  const MapScreen({Key? key}) : super(key: key);

  

  @override 
  MapScreenState createState() => MapScreenState();
}

Set<Marker> allMarkers = {};

class MapScreenState extends State<MapScreen> {



  @override
  initState(){
    //Event temp = Boxes.getEventAt(eventIndex);
    //LatLng cc = LatLng(temp.lat, temp.long);
    //Marker origin = Marker(
    //  markerId: const MarkerId('origin'),
    //  infoWindow: const InfoWindow(title: 'Origin'),
     // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
     // position: LatLng(temp.lat, temp.long)
    //);
    //allMarkers.add(origin);
  }

  Completer<GoogleMapController> _controller = Completer();
  
  //Set<Marker> allMarkers = {};


  Marker destination = Marker(
    markerId: const MarkerId('destination'),
    infoWindow: const InfoWindow(title: 'destination'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: const LatLng(42.744421, -71.1699932)
  );

 
  @override 
  Widget build(BuildContext context) {
    //allMarkers.add(destination);
    //createPolylines(37.42796133580664, -122.085749655962, 37.428, -122.086);
    //CameraPosition inicialPosition = CameraPosition(
    //target: LatLng(Boxes.getEventAt(eventIndex).lat, Boxes.getEventAt(eventIndex).long),
    //zoom: 14.4748
  //);
  
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(20, 20),
            zoom: 14.4748
          ),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        );
      }
}

  



