import 'package:flutter/material.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/client_event_list/client_event_list_bloc.dart';
import 'package:gym_app/logic/client_event_list/client_event_list_event.dart';
import 'package:gym_app/logic/client_event_list/client_event_list_state.dart';
import 'package:gym_app/page/user_event_details.dart';
import 'package:gym_app/widget/bottom_loader.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/widget/event_list_item.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserEventList extends StatefulWidget {

  const UserEventList({
    Key?key,
    required this.username
  }) : super(key: key);

  final username;

  @override
  UserEventListState createState() => UserEventListState(username: username);

}

class UserEventListState extends State<UserEventList> {
  final scrollController = ScrollController();

  UserEventListState({required this.username});
  
  final username;
  
  @override 
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(39, 33, 33,1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(225, 100, 40,1)
        ),
      ),
      backgroundColor: const Color.fromRGBO(54, 51, 51,1),
      body: BlocProvider(
        create: (context) => ClientEventListBloc(repository: const Repository())..add(EventFetched()),
        child: BlocBuilder<ClientEventListBloc, ClientEventListState>(builder: (context, state) {
          switch (state.status) {
            case ClientEventListStatus.failure:
              return const Center(child: Text('Failed to fetch events'));
            case ClientEventListStatus.success:
              if(state.events.isEmpty) {
                return const Center(child: Text('No posts available'));
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.events.length
                        ? const BottomLoader() 
                        : EventListItem(event: state.events[index], username: username);
                },
                itemCount: state.events.length,
                controller: scrollController,
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
          
        }) 
      )
    );
  }

  @override 
  void dispose() {
    scrollController..removeListener(onScroll)..dispose();
    super.dispose();
  }

  void onScroll() {
    if(isBottom) context.read<ClientEventListBloc>().add(EventFetched());
  }

  bool get isBottom {
    if(!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}



/*
ValueListenableBuilder<Box<Event>>(
        valueListenable: Boxes.getEvents().listenable(),
        builder: (context, box, _) {
          final events = box.values.toList().cast<Event>();
          return buildContent(events, userPassword);
        }
      )



BlocBuilder<EventListBloc, EventListState>(builder: (context, state) {
        switch(state.status){
          case EventListStatus.failure:
            return const Center(child: Text('failed'));
          case EventListStatus.success:
            if(state.events.isEmpty){
              return const Center(child: Text('No posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.events.length ? buildBottomLoader(context) : buildEvent(context, state.events[index], index, userPassword);
              } 
              itemCount: state.hasReachedMax ? state.events.length : state.events.length + 1,
              controller: _scrollController,
            );

        }
      })


Widget buildContent(List<Event> events, String userPassword) {
  if(events.isEmpty){
    return const Center(
      child: Text('No events!')
    );
  }else{
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index){
        final event = events[index];
        return buildEvent(context, event, index, userPassword);
      }
    );
  }
}

Widget buildBottomLoader(BuildContext context) {
  return const Center(
    child: SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(strokeWidth: 1.5,)
    ),
  );
}

Widget buildEvent(BuildContext context, Event event, int index, String userPassword) {
  return Container(
    height: 75,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(246, 233, 233,1),
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      border: Border.all(
        color: const Color.fromRGBO(39, 33, 33,1) 
      )
    ),
    child: InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserEventDetails(eventIndex: index, userPassword: userPassword)
        ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            event.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
          )
        ],
      ),
    ) 
    
  );
}


Card(
      color: Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserEventDetails(eventIndex: event.key)
          ));
        },
        child: Row(
          children:  [
            SizedBox(height: 20),
            Text(
            event.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
          )]
        ),
      ),
    )
*/