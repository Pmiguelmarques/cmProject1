import 'package:equatable/equatable.dart';

enum EventMapStatus {initial, success, failed}

class EventMapState extends Equatable{

  const EventMapState({
    this.status = EventMapStatus.initial, 
    this.lat = 0, 
    this.lng = 0
  });

  final EventMapStatus status;
  final double lat;
  final double lng;

  EventMapState copyWith({
    EventMapStatus? status,
    double? lat, 
    double? lng
  }) {
    return EventMapState(
      status: status ?? this.status,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng
    );
  }


  @override 
  List<Object> get props => [status, lat, lng];
}