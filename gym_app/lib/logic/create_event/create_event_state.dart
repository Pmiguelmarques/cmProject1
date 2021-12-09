import 'package:equatable/equatable.dart';

enum CreateEventStatus {initial, success, failure, eventSent}

class CreateEventState extends Equatable {
  const CreateEventState({
    this.status = CreateEventStatus.initial,
    this.name = '',
    this.teacher = '', 
    this.lat = 0, 
    this.long = 0, 
    this.data = ''
  });

  final CreateEventStatus status;
  final String name;
  final String teacher;
  final double lat;
  final double long;
  final String data;
  

  
  CreateEventState copyWith({
    CreateEventStatus? status,
    String? name,
    String? teacher, 
    double? lat, 
    double? long, 
    String? data
  }) {
    return CreateEventState(
      status: status ?? this.status,
      name: name ?? this.name,
      teacher: teacher ?? this.teacher,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      data: data ?? this.data
    );
  }

  @override 
  List<Object> get props => [status, name, teacher, lat, long,data];
  
}