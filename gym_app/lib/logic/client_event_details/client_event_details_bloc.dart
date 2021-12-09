import 'package:bloc/bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/client_event_details/client_event_details.event.dart';
import 'package:gym_app/logic/client_event_details/client_event_details_state.dart';

class ClientEventDetailsBloc extends Bloc<ClientEventDetailsEvent, ClientEventDetailState> {
  ClientEventDetailsBloc({required this.repository}) : super(const ClientEventDetailState()) {
    on<EventDetailsFetched>(_onEventDetailsFetched);
  }

  final Repository repository;

  Future<void> _onEventDetailsFetched(EventDetailsFetched event, Emitter<ClientEventDetailState> emit) async {
    try{
      final fetchedEvent = await repository.getEvent(event.eventName);
      emit(state.copyWith(status: ClientEventDetailStatus.success, teacher: fetchedEvent.teacher, eventName: fetchedEvent.name));

    }catch(_){
      emit(state.copyWith(status: ClientEventDetailStatus.failure));
    }
  }
}