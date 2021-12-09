import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/client_invitation/client_invitation_bloc.dart';
import 'package:gym_app/logic/client_invitation/client_invitation_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ClientInvitation extends StatelessWidget {

  const ClientInvitation({required this.eventName});

  final eventName;

  @override 
  Widget build(BuildContext context) {

    return BlocBuilder<ClientInvitationBloc, ClientInvitationState>(
        builder: (context, state) {
          return state.status == ClientInvitationStatus.visible 
                ? SizedBox(
                  height: 200,
                  width: 200,
                  child: 
                    QrImage(
                      backgroundColor: Colors.white,
                      data:eventName
                    )
                  )
                : state.status == ClientInvitationStatus.invisible || state.status == ClientInvitationStatus.initial
                  ? Container()
                  : const CircularProgressIndicator();
                  
        },
      );
    }
}