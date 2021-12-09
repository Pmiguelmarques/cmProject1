import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/login/login_event.dart';
import 'package:gym_app/logic/register_user/register_user_bloc.dart';
import 'package:gym_app/logic/register_user/register_user_event.dart';
import 'package:gym_app/logic/register_user/register_user_state.dart';

class RegisterUserInput extends StatelessWidget {

  const RegisterUserInput({required this.inputType});

  final inputType;

  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserBloc, RegisterUserState>(
      builder: (context, state) {
        return Container(
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xfff1f1f5),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: inputType == 'firstName' ? 'First name': inputType == 'lastName' ? 'Last name' : 'userName',
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => {
              if(inputType == 'firstName'){
                context.read<RegisterUserBloc>().add(RegisterFirstNameChanged(value))
              }else if(inputType == 'lastName'){
                context.read<RegisterUserBloc>().add(RegisterLastNameChanged(value))
              }else if(inputType == 'userName'){
                context.read<RegisterUserBloc>().add(RegisterUserNameChanged(value))
              }
            }
          ),
        );
      }
    );
  }
}


