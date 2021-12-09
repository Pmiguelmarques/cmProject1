import 'package:equatable/equatable.dart';

abstract class TeacherEventEvent extends Equatable {
  
  const TeacherEventEvent();
  
  @override
  List<Object> get props => [];
}

class TeacherEventFetched extends TeacherEventEvent {
  const TeacherEventFetched(this.username);

  final String username;
  
  @override
  List<Object> get props => [];
}