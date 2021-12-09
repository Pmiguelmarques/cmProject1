import 'package:bloc/bloc.dart';
import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/teacher_events/teacher_event_event.dart';
import 'package:gym_app/logic/teacher_events/teacher_event_state.dart';
import 'package:gym_app/widget/teacher_page/teacher_events.dart';

class TeacherEventBloc extends Bloc<TeacherEventEvent, TeacherEventState>{
  TeacherEventBloc({required this.repository}) : super(const TeacherEventState()) {
    on<TeacherEventFetched>(_onTeacherEventFetched);
  }

  final Repository repository;

  Future<void> _onTeacherEventFetched(TeacherEventFetched event, Emitter<TeacherEventState> emit) async {
    if(state.hasReachedMax) return;
    try {
      if(state.status == TeacherEventStatus.initial) {
        List<Event> newEvents = await _fetchEvents();
        return emit(state.copyWith(
          status: TeacherEventStatus.success,
          events: newEvents,
          hasReachedMax: false
        ));
      }
      final newEvents = await _fetchEvents(state.events.length);
      emit(newEvents.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
            status: TeacherEventStatus.success,
            events: newEvents,
            hasReachedMax: false
          ));
    }catch(_){
      emit(state.copyWith(status: TeacherEventStatus.failure));
    }
  }

  Future<List<Event>> _fetchEvents([int startIndex = 0]) async {
    final response = await repository.getAllEvents();
    return response;
  }
}