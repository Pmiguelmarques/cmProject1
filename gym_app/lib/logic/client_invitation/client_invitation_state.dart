import 'package:equatable/equatable.dart';

enum ClientInvitationStatus {initial, visible, invisible, waiting}

class ClientInvitationState extends Equatable {

  const ClientInvitationState({
    this.status = ClientInvitationStatus.initial
  });

  final ClientInvitationStatus status;

  ClientInvitationState copyWith({
    ClientInvitationStatus? status
  }) {
    return ClientInvitationState(
      status: status ?? this.status
    );
  }

  @override 
  List<Object> get props => [status];

}