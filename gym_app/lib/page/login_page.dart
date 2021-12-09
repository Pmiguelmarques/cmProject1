import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/data/provider.dart';
import 'package:gym_app/logic/login/login_bloc.dart';
import 'package:gym_app/logic/login/login_state.dart';
import 'package:gym_app/page/register_page.dart';
import 'package:gym_app/page/trainer_main_page.dart';
import 'package:gym_app/page/user_main_page.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/widget/login_widgets/login_button.dart';
import 'package:gym_app/widget/login_widgets/login_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  bool failedToLog = false;
  String username = "";
  String password = "";
  Repository rep = Repository();

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(repository: const Repository()),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if(state.status == LoginStatus.failure){
            ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: 
                                Text("Login failed")
                              )
                            );
          }else if(state.status == LoginStatus.success){
            if(state.isTrainer){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TrainerMainPage(trainer: state.username))
              );
            }else{
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserMainPage(username: state.username)
              ));
            }
          }
        },
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(54, 51, 51,1),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Login to your account',
                      style: TextStyle(
                        color: Color.fromRGBO(225, 100, 40,1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),
                    ),
                    const SizedBox(height: 10),
                    if(failedToLog)
                      const Text(
                        'Please try again',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                        ),
                      ),
                    const SizedBox(height: 50),
                    const LoginInput(inputType: 'username'),
                    const SizedBox(height: 24),
                    const LoginInput(inputType: 'password'),
                    const SizedBox(height: 25),
                    const LoginButton(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ).copyWith(color: const Color(0xff94959b)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ); 
     
    
  }
}

