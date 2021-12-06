import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/widget/boxes.dart';

class MapScreen extends StatefulWidget {

  const MapScreen({Key? key,required this.eventIndex}) : super(key: key);

  final eventIndex;

  @override 
  MapScreenState createState() => MapScreenState(eventIndex: eventIndex);
}

Set<Marker> allMarkers = {};

class MapScreenState extends State<MapScreen> {

  MapScreenState({required this.eventIndex});

  final eventIndex;

  @override
  initState(){
    Event temp = Boxes.getEventAt(eventIndex);
    LatLng cc = LatLng(temp.lat, temp.long);
    Marker origin = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: const InfoWindow(title: 'Origin'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(temp.lat, temp.long)
    );
    allMarkers.add(origin);
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
    CameraPosition inicialPosition = CameraPosition(
    target: LatLng(Boxes.getEventAt(eventIndex).lat, Boxes.getEventAt(eventIndex).long),
    zoom: 14.4748
  );
    return GoogleMap(
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: inicialPosition,
      markers: allMarkers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);

      },
    );
  }
}

  



