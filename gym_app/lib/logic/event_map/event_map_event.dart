import 'package:equatable/equatable.dart';

abstract class EventMapEvent extends Equatable {
  EventMapEvent();
  @override 
  List<Object> get props => [];
}

class MapInitEvent extends EventMapEvent {
  MapInitEvent({required this.eventName});

  final String eventName;

  @override 
  List<Object> get props => [];
}