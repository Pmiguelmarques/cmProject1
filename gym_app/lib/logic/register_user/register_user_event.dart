import 'package:equatable/equatable.dart';

abstract class RegisterUserEvent extends Equatable {
  const RegisterUserEvent();

  @override 
  List<Object> get props => [];
}

class NewUserAdd extends RegisterUserEvent {}

class RegisterFirstNameChanged extends RegisterUserEvent {
  const RegisterFirstNameChanged(this.firstName);

  final String firstName;

  @override 
  List<Object> get props => [];
}

class RegisterLastNameChanged extends RegisterUserEvent {
  const RegisterLastNameChanged(this.lastName);

  final String lastName;

  @override 
  List<Object> get props => [];
}

class RegisterUserNameChanged extends RegisterUserEvent {
  const RegisterUserNameChanged(this.userName);

  final String userName;

  @override 
  List<Object> get props => [];
}

class RegisterPasswordChanged extends RegisterUserEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override 
  List<Object> get props => [];
}

class RegisterIsTrainerChanged extends RegisterUserEvent {
  const RegisterIsTrainerChanged(this.isTrainer);

  final bool isTrainer;

  @override 
  List<Object> get props => [];
}

