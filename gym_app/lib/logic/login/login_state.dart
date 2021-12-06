import 'package:equatable/equatable.dart';

enum LoginStatus {initial, success, failure, loginSent}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.username = '',
    this.password = '',
    this.isTrainer = false
  });
  
  final LoginStatus status;
  final String username;
  final String password;
  final bool isTrainer;

  LoginState copyWith({
    LoginStatus? status,
    String? username,
    String? password,
    bool? isTrainer
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isTrainer: isTrainer ?? this.isTrainer
    );
  }

  @override 
  List<Object> get props => [status, username, password, isTrainer];
}