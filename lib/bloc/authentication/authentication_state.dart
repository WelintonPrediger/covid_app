import 'package:covid19/model/model_export.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class RegisterUserState extends AuthenticationState {}

class SavedUserSuccess extends AuthenticationState {

  final String message;

  SavedUserSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthenticatedUser extends AuthenticationState {

  final User user;

  AuthenticatedUser({required this.user});

  @override
  List<Object> get props => [user];
}

class InvalidLogin extends AuthenticationState {

  final String message;

  InvalidLogin({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthenticationErrorState extends AuthenticationState {

  final String message;

  AuthenticationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}