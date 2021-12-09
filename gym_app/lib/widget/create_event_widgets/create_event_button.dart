import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/create_event/create_event_bloc.dart';
import 'package:gym_app/logic/create_event/create_event_event.dart';
import 'package:gym_app/logic/create_event/create_event_state.dart';
import 'package:gym_app/logic/register_user/register_user_bloc.dart';
import 'package:gym_app/logic/register_user/register_user_event.dart';
import 'package:gym_app/logic/register_user/register_user_state.dart';

class CreateEventButton extends StatelessWidget {
  const CreateEventButton({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return state.status == CreateEventStatus.eventSent
              ? const CircularProgressIndicator()
              : SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
                  onPressed: state.status == CreateEventStatus.initial || state.status == CreateEventStatus.success
                          ? () {
                            context.read<CreateEventBloc>().add(NewEventCreated());
                            }
                          : null,
                  child: const Text('Create Event', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)))
                ),
              );
      }
    );
  }
}

