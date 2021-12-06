import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();


  @override 
  List<Object> get props => [];
}

class NewLoginEvent extends LoginEvent {}

class EventUsernameChanged extends LoginEvent {
  const EventUsernameChanged(this.username);

  final String username;

  @override 
  List<Object> get props => [];
}

class EventPasswordChanged extends LoginEvent {
  const EventPasswordChanged(this.password);

  final String password;

  @override 
  List<Object> get props => [];
} 

