import 'package:equatable/equatable.dart';

abstract class ClientRegisterEvent extends Equatable {
   const ClientRegisterEvent();

   @override 
   List<Object> get props => [];
}

class ClientRegistration extends ClientRegisterEvent {
  const ClientRegistration({required this.userName, required this.eventName});

  final String userName;
  final String eventName;

  @override 
   List<Object> get props => [];
}

class ClientUnregistration extends ClientRegisterEvent {
  const ClientUnregistration({required this.userName, required this.eventName});

  final String userName;
  final String eventName;

  @override 
   List<Object> get props => [];
}