import 'dart:developer';

import 'package:covid19/model/model_export.dart';
import 'package:covid19/repository/repository_export.dart';

abstract class AuthenticationServiceHelper {

  Future<bool?> saveUser({required User user});
  Future<User?> getUser({required User userLogin});

}

class AuthenticationService extends AuthenticationServiceHelper {

  late UserRepository _repository;

  @override
  Future<bool?> saveUser({required User user}) async {
    _repository = UserRepository();
    int repositoryResponse = await _repository.save(user);
    log("repo response -> $repositoryResponse");
    if(repositoryResponse != 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<User?> getUser({required User userLogin}) async {

    _repository = UserRepository();
    User? validatedUser;
    List<User> users = await _repository.fetchAll();
    log('List: $users');
    log('UserLogin: $userLogin');

    users.map((user) {
      log('User in Test: $user');
      if(user.email == userLogin.email && user.password == userLogin.password) {
        log('Entrou aqui');
        validatedUser = user;
      }
    }).toList();

    log('USUÁRIO: $validatedUser');

    if(validatedUser != null) {
      return validatedUser;
    }
    return null;
  }

}

