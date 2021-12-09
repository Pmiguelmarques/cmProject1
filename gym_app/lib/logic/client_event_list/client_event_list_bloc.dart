import 'package:bloc/bloc.dart';
import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/client_event_list/client_event_list_event.dart';
import 'package:gym_app/logic/client_event_list/client_event_list_state.dart';

class ClientEventListBloc extends Bloc<ClientEventListEvent, ClientEventListState> {
  ClientEventListBloc({required this.repository}) : super(const ClientEventListState()){
    on<EventFetched>(_onEventFetch);
  }

  final Repository repository;

  Future<void> _onEventFetch(EventFetched event, Emitter<ClientEventListState> emit) async {
    if(state.hasReachedMax) return;
    try{
      if(state.status == ClientEventListStatus.initial) {
        List<Event> newEvents = await _fetchEvents();
        return emit(state.copyWith(
          status: ClientEventListStatus.success,
          events: newEvents,
          hasReachedMax: false
        ));
      }
      final newEvents = await _fetchEvents(state.events.length);
      emit(newEvents.length == state.events.length 
          ? state.copyWith(hasReachedMax: true, status: ClientEventListStatus.success)
          : state.copyWith(
            status: ClientEventListStatus.success,
            events: newEvents,
            hasReachedMax: false 
          ));
    }catch(_){
      emit(state.copyWith(status: ClientEventListStatus.failure));
    }
  }

  Future<List<Event>> _fetchEvents([int startIndex = 0]) async {
    final response = await repository.getAllEvents();
    return response;
  }
  

}