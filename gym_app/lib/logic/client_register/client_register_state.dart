import 'package:equatable/equatable.dart';

enum ClientRegisterStatus {initial, registered, unregistered, failed, waiting}

class ClientRegisterState extends Equatable {
  const ClientRegisterState({
    this.status = ClientRegisterStatus.initial,
    this.isRegistered = false
  });

  final ClientRegisterStatus status;
  final bool isRegistered;

  ClientRegisterState copyWith({
    ClientRegisterStatus? status,
    bool? isRegistered
  }) {
    return ClientRegisterState(
      status: status ?? this.status,
      isRegistered: isRegistered ?? this.isRegistered
    );
  }

  @override 
  List<Object> get props => [status, isRegistered];
}