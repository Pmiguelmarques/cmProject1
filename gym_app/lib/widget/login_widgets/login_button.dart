import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/login/login_bloc.dart';
import 'package:gym_app/logic/login/login_event.dart';
import 'package:gym_app/logic/login/login_state.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status == LoginStatus.loginSent
              ? const CircularProgressIndicator()
              : SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
                  onPressed: state.status == LoginStatus.initial || state.status == LoginStatus.success
                          ? () {
                            context.read<LoginBloc>().add(NewLoginEvent());
                            }
                          : null,
                  child: const Text('Login', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)))
                ),
              );
      }
    );
  }
}

/*
SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
                        onPressed: (){
                          final client = Boxes.getClient(password);
                          if(client == null){
                            setState(() {
                              failedToLog = true;
                            });
                          }else{
                            setState(() {
                              failedToLog = false;
                            });
                            if(client.userName != username || client.password != password){
                              failedToLog = true;
                            }else{
                              if(client.isTrainer) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TrainerMainPage(trainerPassword: client.password))
                                );
                              }else{
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserMainPage(userPassword: client.password)
                                ));
                              }
                            }
                          }
                        }, 
                        child: const Text('Login', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)))
                      ),
                    )



onPressed: state.status == LoginStatus.initial
                        ? () {
                          context.read<LoginBloc>().add(NewLoginEvent());
                          }
                        : null,
*/