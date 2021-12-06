import 'package:bloc/bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/login/login_event.dart';
import 'package:gym_app/logic/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.repository}) : super(const LoginState()) {
    on<NewLoginEvent>(_onLoginEvent);
    on<EventUsernameChanged>(_onUserNameChanged);
    on<EventPasswordChanged>(_onPasswordChanged);
  }

  final Repository repository;

  void _onLoginEvent(LoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loginSent));
    try{
      String response = await repository.checkLogIn(state.username, state.password);
      if(response == "successTrainer"){
        emit(state.copyWith(status: LoginStatus.success, isTrainer: true));
      }else if(response == "successUser"){
        emit(state.copyWith(status: LoginStatus.success, isTrainer: false));
      }else{
        emit(state.copyWith(status: LoginStatus.failure));
      }
    }catch(_){
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }

  void _onUserNameChanged(EventUsernameChanged event, Emitter<LoginState> emit) async {
    final username = event.username;
    
    emit(state.copyWith(username: username));
  }

  void _onPasswordChanged(EventPasswordChanged event, Emitter<LoginState> emit) async {
    final password = event.password;
    emit(state.copyWith(password: password));
  }
}