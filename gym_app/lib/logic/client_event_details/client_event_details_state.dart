import 'package:equatable/equatable.dart';

enum ClientEventDetailStatus {initial, success, failure}

class ClientEventDetailState extends Equatable {
  const ClientEventDetailState({
    this.status = ClientEventDetailStatus.initial,
    this.teacher = '',
    this.eventName = ''
  });

  final ClientEventDetailStatus status;
  final String teacher;
  final String eventName;

  ClientEventDetailState copyWith({
    ClientEventDetailStatus? status,
    String? teacher,
    String? eventName
  }) {
    return ClientEventDetailState(
      status: status ?? this.status,
      teacher: teacher ?? this.teacher,
      eventName: eventName ?? this.eventName
    );
  }

  @override 
  List<Object> get props => [status, teacher, eventName];
}