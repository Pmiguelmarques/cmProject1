import 'package:bloc/bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/register_user/register_user_event.dart';
import 'package:gym_app/logic/register_user/register_user_state.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  RegisterUserBloc({required this.repository}) : super(const RegisterUserState()){
    on<NewUserAdd>(_onNewUserAdd);
    on<RegisterFirstNameChanged>(_onFirstNameChanged);
    on<RegisterLastNameChanged>(_onLastNameChanged);
    on<RegisterUserNameChanged>(_onUserNameChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterIsTrainerChanged>(_onIsTrainerChanged);
  }

  final Repository repository;

  void _onNewUserAdd(NewUserAdd event, Emitter<RegisterUserState> emit) async {
    emit(state.copyWith(status: RegisterUserStatus.eventSent));
    try {
      final response = await repository.insertUser(state.firstName, state.lastName, state.userName, state.password, state.isTrainer);
      if(response == 'Success'){
        emit(state.copyWith(status: RegisterUserStatus.success));
      }else{
        emit(state.copyWith(status: RegisterUserStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(status: RegisterUserStatus.failure));
    }
  }

  void _onFirstNameChanged(RegisterFirstNameChanged event, Emitter<RegisterUserState> emit) async {
    final firstName = event.firstName;
    emit(state.copyWith(firstName: firstName));
  }

  void _onLastNameChanged(RegisterLastNameChanged event, Emitter<RegisterUserState> emit) async {
    final lastName = event.lastName;
    emit(state.copyWith(lastName: lastName));
  }
  
  void _onUserNameChanged(RegisterUserNameChanged event, Emitter<RegisterUserState> emit) async {
    final userName = event.userName;
    emit(state.copyWith(userName: userName));
  }

  void _onPasswordChanged(RegisterPasswordChanged event, Emitter<RegisterUserState> emit) async {
    final password = event.password;
    emit(state.copyWith(password: password));
  }

  void _onIsTrainerChanged(RegisterIsTrainerChanged event, Emitter<RegisterUserState> emit) async {
    final isTrainer = event.isTrainer;
    emit(state.copyWith(isTrainer: isTrainer));
  }

}