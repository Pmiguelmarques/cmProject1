import 'package:equatable/equatable.dart';

abstract class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override 
  List<Object> get props => [];
}

class NewEventCreated extends CreateEventEvent {}

class EventNameChanged extends CreateEventEvent {
  const EventNameChanged(this.name);

  final String name;

  @override 
  List<Object> get props => [];
}

class EventTeacherChanged extends CreateEventEvent {
  const EventTeacherChanged(this.teacher);

  final String teacher;

  @override 
  List<Object> get props => [];
}

class EventLatChanged extends CreateEventEvent {
  const EventLatChanged(this.lat);

  final double lat;

  @override 
  List<Object> get props => [];
}

class EventLongChanged extends CreateEventEvent {
  const EventLongChanged(this.long);

  final double long;

  @override 
  List<Object> get props => [];
}
