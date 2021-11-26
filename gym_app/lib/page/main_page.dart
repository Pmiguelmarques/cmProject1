import 'package:flutter/material.dart';
import 'package:gym_app/page/user_movement_page.dart';
import 'package:gym_app/page/create_event.dart';
import 'package:gym_app/page/map.dart';
import 'package:gym_app/page/view_events.dart';
import 'package:gym_app/page/trainer_main_page.dart';

class MainPage extends StatefulWidget {

  @override 
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  static const String title = 'Main Page';
  int selectedIndex = 0;
  final screens = [];
  
  @override 
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);

    return Scaffold(
      body: Text('ola'),
      //body: TrainerMainPage() 
      );
  }
}


/*
class MainPage extends StatelessWidget {

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Main Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage()
                ));
                
              }, child: const Text('Accelerometer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QrPage())
                );
              },
              child: const Text('QrCodePage')
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MapSample()
                ));
              }, 
              child: const Text('Map')
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EventCreator()
                ));
              }, 
              child: const Text('Create Event')
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EventViewer()
                ));
              },
              child: const Text('View Event')
            ),
          ],
        ),
      ),
    );
  }
}
*/