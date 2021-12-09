import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/create_event/create_event_bloc.dart';
import 'package:gym_app/logic/create_event/create_event_event.dart';
import 'package:gym_app/logic/create_event/create_event_state.dart';


class CreateEventInput extends StatelessWidget {

  const CreateEventInput({required this.inputType});

  final inputType;

  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return Container(
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xfff1f1f5),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: inputType == 'name' ? 'Event name' 
                      : inputType == 'lat'  ? 'Latitude'
                      : 'Longitude',
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => {
              if(inputType == 'name'){
                context.read<CreateEventBloc>().add(EventNameChanged(value))
              }else if(inputType == 'lat'){
                context.read<CreateEventBloc>().add(EventLatChanged(double.parse(value)))
              }
              else if(inputType == 'long'){
                context.read<CreateEventBloc>().add(EventLongChanged(double.parse(value)))
              }
            }
          ),
        );
      }
    );
  }
}


