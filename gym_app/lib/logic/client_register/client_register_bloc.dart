import 'package:bloc/bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/client_register/client_register_event.dart';
import 'package:gym_app/logic/client_register/client_register_state.dart';

class ClientRegisterBloc extends Bloc<ClientRegisterEvent, ClientRegisterState> {
  ClientRegisterBloc({required this.repository}) : super(const ClientRegisterState()) {
    on<ClientRegistration>(_onClientRegistration);
    on<ClientUnregistration>(_onClientUnregistration);
  }

  final Repository repository;

  Future<void> _onClientRegistration(ClientRegistration event, Emitter<ClientRegisterState> emit) async {
    emit(state.copyWith(status: ClientRegisterStatus.waiting));
    try{
      await repository.registerClientInEvent(event.userName, event.eventName);
      emit(state.copyWith(status: ClientRegisterStatus.registered, isRegistered: true));
    }catch(_){
      emit(state.copyWith(status: ClientRegisterStatus.failed));
    }
  }

  Future<void> _onClientUnregistration(ClientUnregistration event, Emitter<ClientRegisterState> emit) async {
    emit(state.copyWith(status: ClientRegisterStatus.waiting));
    try{
      await repository.unregisterClientFromEvent(event.userName, event.eventName);
      emit(state.copyWith(status: ClientRegisterStatus.unregistered, isRegistered: false));
    }catch(_){
      emit(state.copyWith(status: ClientRegisterStatus.failed));
    }
  }
}