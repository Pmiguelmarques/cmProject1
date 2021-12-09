import 'package:equatable/equatable.dart';

enum TeacherInfoStatus {initial, success, failure}

class TeacherInfoState extends Equatable {
  const TeacherInfoState({
    this.status = TeacherInfoStatus.initial,
    this.firstName = '',
    this.lastName = '',
    this.userName = ''
  });

  final TeacherInfoStatus status;
  final String firstName;
  final String lastName;
  final String userName;

  TeacherInfoState copyWith({
    TeacherInfoStatus? status, 
    String? firstName,
    String? lastName,
    String? userName
  }) {
    return TeacherInfoState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName
    );
  }

  @override 
  List<Object> get props => [status, firstName, lastName, userName];
}