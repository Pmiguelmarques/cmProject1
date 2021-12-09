import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gym_app/logic/client_invitation/client_invitation_event.dart';
import 'package:gym_app/logic/client_invitation/client_invitation_state.dart';
import 'package:gym_app/logic/client_register/client_register_bloc.dart';
import 'package:gym_app/logic/client_register/client_register_state.dart';

class ClientInvitationBloc extends Bloc<ClientInvitationEvent, ClientInvitationState> {
  
  ClientInvitationBloc({required this.clientRegistration}) : super(const ClientInvitationState()) {
    registrationBlocSubscription = clientRegistration.stream.listen((event) { 
      if(event.status == ClientRegisterStatus.registered){
        _onClientRegistered();
      }else if(event.status == ClientRegisterStatus.unregistered){
        _onClientUnregistered();
      }else{
        _onClientWaiting();
      }
    });
  }

  final ClientRegisterBloc clientRegistration;
  late final StreamSubscription registrationBlocSubscription;

  Future<void> _onClientRegistered() async {
    emit(state.copyWith(status: ClientInvitationStatus.visible));
  }
  Future<void> _onClientUnregistered() async {
    emit(state.copyWith(status: ClientInvitationStatus.invisible));
  }
  Future<void> _onClientWaiting() async {
    emit(state.copyWith(status: ClientInvitationStatus.waiting));
  }
  
  

  @override 
  Future<void> close(){
    registrationBlocSubscription.cancel();
    return super.close();
  }
}