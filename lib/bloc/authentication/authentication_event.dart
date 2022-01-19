import 'package:covid19/model/model_export.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitEvent extends AuthenticationEvent {}

class RegisterUserEvent extends AuthenticationEvent {}

class SaveUserEvent extends AuthenticationEvent {

  final User user;

  SaveUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginEvent extends AuthenticationEvent {

  final User user;

  LoginEvent({required this.user});

  @override
  List<Object> get props => [user];
}