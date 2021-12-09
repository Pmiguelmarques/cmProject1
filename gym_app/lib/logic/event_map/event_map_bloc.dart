import 'package:bloc/bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/event_map/event_map_event.dart';
import 'package:gym_app/logic/event_map/event_map_state.dart';

class EventMapBloc extends Bloc<EventMapEvent, EventMapState> {
  EventMapBloc({required this.repository}) : super(const EventMapState()){
    on<MapInitEvent>(_onEventMapEvent);
  }

  final Repository repository;

  Future<void> _onEventMapEvent(MapInitEvent event, Emitter<EventMapState> emit) async{
    try{
      final rawEvent = await repository.getEvent(event.eventName);
      emit(state.copyWith(lat: rawEvent.lat, lng: rawEvent.long, status: EventMapStatus.success));
    }catch(_){
      emit(state.copyWith(status: EventMapStatus.failed));
    }
  }
}