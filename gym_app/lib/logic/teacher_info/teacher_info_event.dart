import 'package:equatable/equatable.dart';

abstract class TeacherInfoEvent extends Equatable {
  const TeacherInfoEvent();

  @override 
  List<Object> get props => [];
}

class TeacherInfoFetch extends TeacherInfoEvent {
  const TeacherInfoFetch(this.username);

  final String username;

  @override 
  List<Object> get props => [];
}