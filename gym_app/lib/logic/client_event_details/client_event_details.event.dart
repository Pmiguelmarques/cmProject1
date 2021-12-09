import 'package:equatable/equatable.dart';

abstract class ClientEventDetailsEvent extends Equatable {
  
  const ClientEventDetailsEvent();

  @override 
  List<Object> get props => [];
}

class EventDetailsFetched extends ClientEventDetailsEvent {
  const EventDetailsFetched({required this.eventName});

  final String eventName;

  @override
  List<Object> get props => [];
}