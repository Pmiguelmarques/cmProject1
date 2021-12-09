import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/register_user/register_user_bloc.dart';
import 'package:gym_app/logic/register_user/register_user_state.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:gym_app/data/model/client.dart';
import 'package:gym_app/widget/register_widgets/register_user_button.dart';
import 'package:gym_app/widget/register_widgets/register_user_input.dart';
import 'package:gym_app/widget/register_widgets/register_user_is_trainer.dart';
import 'package:gym_app/widget/register_widgets/register_user_password.dart';

enum ClientType {client, trainer}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }
  
  String firstName = '';
  String lastName = '';
  String userName = '';
  String password = '';

  ClientType? cType = ClientType.client;
  bool isTrainer = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterUserBloc(repository: const Repository()),
      child: BlocListener<RegisterUserBloc, RegisterUserState>(
        listener: (context, state) {
          if(state.status == RegisterUserStatus.failure){
            ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: 
                                Text("Registration failed")
                              )
                            );
          }else if(state.status == RegisterUserStatus.success){
             ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: 
                                Text("Registration successful")
                              )
                            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(54, 51, 51,1),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 75),
              Center(
                child: Column(
                  children: const [
                    Text(
                      'Register your account',
                      style: TextStyle(
                        color: Color.fromRGBO(225, 100, 40,1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),
                    ),
                    SizedBox(height: 10),
                    RegisterUserInput(inputType: 'firstName'),
                    SizedBox(height: 12),
                    RegisterUserInput(inputType: 'lastName'),
                    SizedBox(height: 12),
                    RegisterUserInput(inputType: 'userName'),
                    SizedBox(height: 12),
                    RegisterUserPassword(),
                    RegisterUserIsTrainer(),
                    RegisterUserButton()
                  ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}

Future addTransaction(String firstName, String lastName, String userName, String password, bool isTrainer) async {

  final client = Client()
  ..firstName = firstName
  ..lastName = lastName
  ..userName = userName
  ..password = password
  ..isTrainer = isTrainer
  ..events = [];

  final box = Boxes.getClients();
  box.put(password, client);

}

