import 'package:flutter/material.dart';
import 'package:gym_app/page/user_home_page.dart';
import 'package:gym_app/page/user_movement_page.dart';
import 'package:gym_app/page/user_event_list.dart';

class UserMainPage extends StatefulWidget {

  UserMainPage({Key?key, required this.username}) : super(key: key);

  final username;

  @override 
  UserMainPageState createState() => UserMainPageState(username: username);

}

class UserMainPageState extends State<UserMainPage> {
  final username;
  
  UserMainPageState({required this.username});

  PageController pageController = PageController(initialPage: 0);
  int selectedIndex = 0;
  

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Center(
        child: PageView(
          controller: pageController,
          onPageChanged: (newIndex) {
            setState(() {
              selectedIndex = newIndex;
            });
          },
          children: <Widget>[
            UserHomePage(userPassword: username),
            UserEventList(username: username),
            UserMovement(),
          ]
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home', backgroundColor: Color.fromRGBO(246, 233, 233,1)),
          BottomNavigationBarItem(icon: Icon(Icons.event),label: 'Events',backgroundColor: Color.fromRGBO(246, 233, 233,1),),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad_rounded),label: 'Warm Up',backgroundColor: Color.fromRGBO(246, 233, 233,1))
        ],
        currentIndex: selectedIndex,
        onTap: (page) {
          pageController.animateToPage(page, duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
        unselectedItemColor: const Color.fromRGBO(54, 51, 51,1),
        selectedItemColor: const Color.fromRGBO(225, 100, 40,1),
      )
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}


/*
BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromRGBO(246, 233, 233,1)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
            backgroundColor: Color.fromRGBO(246, 233, 233,1),
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad_rounded),
            label: 'Warm Up',
            backgroundColor: Color.fromRGBO(246, 233, 233,1)
          )
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: const Color.fromRGBO(54, 51, 51,1),
        selectedItemColor: const Color.fromRGBO(225, 100, 40,1),
        onTap: onItemTapped,
      ),
(Center(
        child: PageView(
          controller: pageController,
          onPageChanged: (newIndex) {
            setState(() {
              selectedIndex = newIndex;
            });
          },
          children: <Widget>[
            UserHomePage(userPassword: userPassword),
            UserEventList(userPassword: userPassword),
            UserMovement(),
          ]
        )
      ))



*/