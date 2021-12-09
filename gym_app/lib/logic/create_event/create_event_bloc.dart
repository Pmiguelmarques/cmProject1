import 'package:bloc/bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/create_event/create_event_event.dart';
import 'package:gym_app/logic/create_event/create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  CreateEventBloc({required this.repository}) : super(const CreateEventState()){
    on<NewEventCreated>(_onNewEventCreated);
    on<EventNameChanged>(_onEventNameChanged);
    on<EventTeacherChanged>(_onEventTeacherChanged);
    on<EventLatChanged>(_onEventLatChanged);
    on<EventLongChanged>(_onEventLongChanged);
  }

  final Repository repository;

  void _onNewEventCreated(NewEventCreated event, Emitter<CreateEventState> emit) async {
    emit(state.copyWith(status: CreateEventStatus.eventSent, data: state.teacher + state.lat.toString() + state.name));
    try {
      final response = await repository.insertEvent(state.name, state.teacher, state.lat, state.long, state.data);
      if(response == 'Success'){
        emit(state.copyWith(status: CreateEventStatus.success));
      }else{
        emit(state.copyWith(status: CreateEventStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(status: CreateEventStatus.failure));
    }
  }

  void _onEventNameChanged(EventNameChanged event, Emitter<CreateEventState> emit) async {
    final name = event.name;
    emit(state.copyWith(name: name));
  }

  void _onEventTeacherChanged(EventTeacherChanged event, Emitter<CreateEventState> emit) async {
    final teacher = event.teacher;
    emit(state.copyWith(teacher: teacher));
  }
  
  void _onEventLatChanged(EventLatChanged event, Emitter<CreateEventState> emit) async {
    final lat = event.lat;
    emit(state.copyWith(lat: lat));
  }

  void _onEventLongChanged(EventLongChanged event, Emitter<CreateEventState> emit) async {
    final long = event.long;
    emit(state.copyWith(long: long));
  }



}