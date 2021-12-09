import 'package:equatable/equatable.dart';
import 'package:gym_app/data/model/event.dart';

enum TeacherEventStatus {initial, success, failure}

class TeacherEventState extends Equatable {
  const TeacherEventState({
    this.status = TeacherEventStatus.initial,
    this.events = const<Event>[],
    this.hasReachedMax = false
  });

  final TeacherEventStatus status;
  final List<Event> events;
  final bool hasReachedMax;

  TeacherEventState copyWith({
    TeacherEventStatus? status,
    List<Event>? events,
    bool? hasReachedMax
  }) {
    return TeacherEventState(
      status: status ?? this.status,
      events: events ?? this.events,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }

  @override 
  List<Object> get props => [status, events, hasReachedMax];
}