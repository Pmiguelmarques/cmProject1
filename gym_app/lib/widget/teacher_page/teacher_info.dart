import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/teacher_info/teacher_info_bloc.dart';
import 'package:gym_app/logic/teacher_info/teacher_info_event.dart';
import 'package:gym_app/logic/teacher_info/teacher_info_state.dart';

class TeacherInfo extends StatelessWidget {

  const TeacherInfo({required this.username});

  final username;
  
  @override 
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherInfoBloc(repository: const Repository())..add(TeacherInfoFetch(username)),
      child: BlocBuilder<TeacherInfoBloc, TeacherInfoState>(
        builder: (context, state) {
          return Text(
              "Welcome back ${state.firstName} ${state.lastName}",
              style: const TextStyle(
                color: Color.fromRGBO(225, 100, 40,1),
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            );
        })
    );
  }
}