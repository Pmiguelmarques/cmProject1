import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';


class UserMovement extends StatefulWidget {
  UserMovement({Key?key}):super(key: key);

  UserMovementState createState() => UserMovementState(); 
}

class UserMovementState extends State<UserMovement> {
  List<double>? accelerometerValues;
  String? currentState = 'Stopped';
  int numReps = 0;
  double? accel;
  final streamSubscription = <StreamSubscription<dynamic>>[];

  Widget build(BuildContext context) {
    final movementState = currentState;
    //final file = new File('${await getTemporayDirectory().path}/ding.mp3');
    //final accelerometer = accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Move It!', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(39, 33, 33,1)
      ),
      backgroundColor: const Color.fromRGBO(54, 51, 51,1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      color:  Color.fromRGBO(39, 33, 33,1),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(246, 233, 233,1),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Text('${numReps}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 100),),
                  )
                ],
              ),
            )
          ]
      ),
    );
  }

  @override 
  void dispose(){
    super.dispose();
    for(final subscription in streamSubscription){
      subscription.cancel();
    }
  }
  

  @override 
  void initState(){
    super.initState();
    streamSubscription.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState((){
            accel = event.z;
            if(currentState == 'Stopped' && event.z > 1){
              currentState = 'Positive';
            }
            else if(currentState == 'Positive' && event.z <= -1){
              currentState = 'Negative';
            }else if(currentState == 'Negative' && event.z >= 1){
              numReps += 1;
              currentState = 'Positive';
            }
            //accelerometerValues = <double>[event.x, event.y, event.z];
          });
        }
      )
    );
  }
}

/*
mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black38),
              ),
              child: Text('ok'),
            ),
          ),
          Padding( 
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Text('Accelerometer: $accelerometer')
                Text('$numReps'), 
                Text('$currentState'),
                Text('$accel')
              ],
            ),
          ),
          
        ],
*/