import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/client_event_details/client_event_details.event.dart';
import 'package:gym_app/logic/client_event_details/client_event_details_bloc.dart';
import 'package:gym_app/logic/client_event_details/client_event_details_state.dart';

class ClientEventDetails extends StatelessWidget {

  const ClientEventDetails({required this.eventname});

  final String eventname;

  @override 
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientEventDetailsBloc(repository: const Repository())..add(EventDetailsFetched(eventName: eventname)),
      child: BlocBuilder<ClientEventDetailsBloc, ClientEventDetailState>(
        builder: (context, state){
          return  Center(
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
                  Text(state.eventName, style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(225, 100, 40,1))),
                  const SizedBox(height: 20),
                  Text("Hosted by: ${state.teacher}",style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(246, 233, 233,1)),)
                ]
              ),
            )
          );
        },
      ),
    );
  }
}