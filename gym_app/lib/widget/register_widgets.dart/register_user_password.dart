import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/register_user/register_user_bloc.dart';
import 'package:gym_app/logic/register_user/register_user_event.dart';
import 'package:gym_app/logic/register_user/register_user_state.dart';

class RegisterUserPassword extends StatefulWidget {

  const RegisterUserPassword();

  RegisterUserPasswordState createState() => RegisterUserPasswordState();
}

class RegisterUserPasswordState extends State<RegisterUserPassword> {

  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }


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
            obscureText: !passwordVisible,
            decoration:  InputDecoration(
              hintText: 'Password',
              hintStyle:  const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                color: const Color(0xff94959b),
                splashRadius: 1,
                icon: Icon(passwordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
                onPressed: togglePassword,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => {
              context.read<RegisterUserBloc>().add(RegisterPasswordChanged(value))
            }
          ),
        );
      }
    );
  }
}


