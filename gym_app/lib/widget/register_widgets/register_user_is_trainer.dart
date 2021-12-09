import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/register_user/register_user_bloc.dart';
import 'package:gym_app/logic/register_user/register_user_event.dart';
import 'package:gym_app/logic/register_user/register_user_state.dart';


enum ClientType {client, trainer}

class RegisterUserIsTrainer extends StatefulWidget {

  const RegisterUserIsTrainer();

  RegisterUserIsTrainerState createState() => RegisterUserIsTrainerState();
}

class RegisterUserIsTrainerState extends State<RegisterUserIsTrainer> {

  ClientType? cType = ClientType.client;
  bool isTrainer = false;
 
  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserBloc, RegisterUserState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              title: const Text("Regular user", style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
              leading: Radio<ClientType>(
                activeColor: const Color.fromRGBO(225, 100, 40,1),
                value: ClientType.client,
                groupValue: cType,
                onChanged: (ClientType? value){
                  setState(() {
                    cType = value;
                    isTrainer = false;
                  });
                  context.read<RegisterUserBloc>().add(RegisterIsTrainerChanged(isTrainer));
                }
              ),
            ),
            ListTile(
              title: const Text("Trainer", style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
              leading: Radio<ClientType>(
                activeColor: const Color.fromRGBO(225, 100, 40,1),
                value: ClientType.trainer,
                groupValue: cType,
                onChanged: (ClientType? value){
                  setState(() {
                    cType = value;
                    isTrainer = true;
                  });
                  context.read<RegisterUserBloc>().add(RegisterIsTrainerChanged(isTrainer));
                }
              ),
            )
          ],
        );
      }
    );
  }
}


