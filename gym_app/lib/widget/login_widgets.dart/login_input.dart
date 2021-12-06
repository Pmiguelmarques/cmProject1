import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/login/login_bloc.dart';
import 'package:gym_app/logic/login/login_event.dart';
import 'package:gym_app/logic/login/login_state.dart';

class LoginInput extends StatelessWidget {

  const LoginInput({required this.inputType});

  final inputType;

  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xfff1f1f5),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: inputType == 'username' ? 'Username' : 'Password',
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => {
              if(inputType == 'username'){
                context.read<LoginBloc>().add(EventUsernameChanged(value))
              }else if(inputType == 'password'){
                context.read<LoginBloc>().add(EventPasswordChanged(value))
              }
            }
          ),
        );
      }
    );
  }
}


