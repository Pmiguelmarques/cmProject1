import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/register_user/register_user_bloc.dart';
import 'package:gym_app/logic/register_user/register_user_event.dart';
import 'package:gym_app/logic/register_user/register_user_state.dart';

class RegisterUserButton extends StatelessWidget {
  const RegisterUserButton({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserBloc, RegisterUserState>(
      builder: (context, state) {
        return state.status == RegisterUserStatus.eventSent
              ? const CircularProgressIndicator()
              : SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
                  onPressed: state.status == RegisterUserStatus.initial || state.status == RegisterUserStatus.success
                          ? () {
                            context.read<RegisterUserBloc>().add(NewUserAdd());
                            }
                          : null,
                  child: const Text('Register', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)))
                ),
              );
      }
    );
  }
}

