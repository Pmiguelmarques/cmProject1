import 'package:equatable/equatable.dart';

abstract class ClientEventListEvent extends Equatable {
  @override 
  List<Object> get props => [];
}

class EventFetched extends ClientEventListEvent {}