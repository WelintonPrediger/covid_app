import 'dart:developer';

import 'package:covid19/bloc/bloc_export.dart';
import 'package:covid19/model/model_export.dart';
import 'package:covid19/service/service_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final AuthenticationService _authenticationService;

  AuthenticationBloc(this._authenticationService) : super(AuthenticationInitState()) {

    on<AuthenticationInitEvent>((event, emit) => emit(AuthenticationInitState()));
    on<RegisterUserEvent>((event, emit) => emit(RegisterUserState()));
    on<SaveUserEvent>((event, emit) => _registerNewUser(event, emit));
    on<LoginEvent>((event, emit) => _login(event, emit));

  }

  Future<void> _registerNewUser(SaveUserEvent event, Emitter<AuthenticationState> emit) async {

    log('Register new user');

    emit(AuthenticationLoadingState());

    try {

      bool? saveNewUser = await _authenticationService.saveUser(user: event.user);

      if(saveNewUser!) {
        emit(SavedUserSuccess(message: 'Usuário cadastrado com sucesso'));
      } else {
        emit(AuthenticationErrorState(message: 'Não foi possível salvar usuário.'));
      }

    } catch(error) {
      emit(AuthenticationErrorState(message: 'Ops algum problema ocorreu. $error'));
    }

  }

  Future<void> _login(LoginEvent event, Emitter<AuthenticationState> emit) async {

    log('Login');

    emit(AuthenticationLoadingState());

    try {

      User? user = await _authenticationService.getUser(userLogin: event.user);

      if(user != null) {
        emit(AuthenticatedUser(user: user));
      } else {
        emit(InvalidLogin(message: 'Ops usuário ou senha inválidos.'));
      }

    } catch(error) {
      emit(AuthenticationErrorState(message: 'Ops algum erro ocorreu. $error'));
    }

  }

}