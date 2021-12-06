import 'package:equatable/equatable.dart';

enum RegisterUserStatus {initial, success, failure, eventSent}

class RegisterUserState extends Equatable {
  const RegisterUserState({
    this.status = RegisterUserStatus.initial,
    this.firstName = '',
    this.lastName = '', 
    this.userName = '', 
    this.password = '', 
    this.isTrainer = false
  });

  final RegisterUserStatus status;
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final bool isTrainer;
  

  
  RegisterUserState copyWith({
    RegisterUserStatus? status,
    String? firstName,
    String? lastName, 
    String? userName, 
    String? password, 
    bool? isTrainer,
  }) {
    return RegisterUserState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isTrainer: isTrainer ?? this.isTrainer,
    );
  }

  @override 
  List<Object> get props => [status, firstName, lastName, userName, password, isTrainer];
  
}