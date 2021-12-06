import 'package:equatable/equatable.dart';
import 'package:gym_app/data/model/event.dart';

enum ClientEventListStatus {initial, success, failure}

class ClientEventListState extends Equatable {
  const ClientEventListState({
    this.status = ClientEventListStatus.initial,
    this.events = const<Event>[],
    this.hasReachedMax = false
  });

  final ClientEventListStatus status;
  final List<Event> events;
  final bool hasReachedMax;

  ClientEventListState copyWith({
    ClientEventListStatus? status,
    List<Event>? events,
    bool? hasReachedMax
    }) {
      return ClientEventListState (
        status: status ?? this.status,
        events: events ?? this.events,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax
      );
    }

    @override 
    String toString() {
      return 'EventStatus {$status , $events , $hasReachedMax}';
    }

    @override 
    List<Object> get props => [status, events, hasReachedMax];
}
