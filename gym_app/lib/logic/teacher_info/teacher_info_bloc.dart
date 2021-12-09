import 'package:bloc/bloc.dart';
import 'package:gym_app/data/model/client.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/teacher_info/teacher_info_event.dart';
import 'package:gym_app/logic/teacher_info/teacher_info_state.dart';

class TeacherInfoBloc extends Bloc<TeacherInfoEvent, TeacherInfoState> {
  TeacherInfoBloc({required this.repository}) : super(const TeacherInfoState()) {
    on<TeacherInfoFetch>(_onTeacherInfoFetch);
  }

  final Repository repository;

  void _onTeacherInfoFetch(TeacherInfoFetch event, Emitter<TeacherInfoState> emit) async {
    try{
      Client client = await repository.getClient(event.username);
      emit(state.copyWith(firstName: client.firstName, lastName: client.lastName, status: TeacherInfoStatus.success));
    }catch(_){
      emit(state.copyWith(status: TeacherInfoStatus.failure));
    }
  }
}