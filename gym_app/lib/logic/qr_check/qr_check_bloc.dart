import 'package:bloc/bloc.dart';
import 'package:gym_app/logic/qr_check/qr_check_event.dart';
import 'package:gym_app/logic/qr_check/qr_check_state.dart';

class QrCheckBloc extends Bloc<QrCheckEvent, QrCheckState>{
  QrCheckBloc() : super(const QrCheckState()){
    on<QrFound>(_onQrFound);
  }

  Future<void> _onQrFound(QrFound event, Emitter<QrCheckState> emit) async {
    try{
      if(event.result == 'dota'){
        emit(state.copyWith(status: QrCheckStatus.success));
      }else{
        emit(state.copyWith(status: QrCheckStatus.denied));
      }
    }catch(_){
      emit(state.copyWith(status: QrCheckStatus.failed));
    }
  }
  
}