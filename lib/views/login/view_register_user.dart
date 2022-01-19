import 'dart:developer';

import 'package:covid19/app_config/app_config_export.dart';
import 'package:covid19/bloc/bloc_export.dart';
import 'package:covid19/components/components_export.dart';
import 'package:covid19/model/model_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewRegisterUser extends StatefulWidget {
  const ViewRegisterUser({Key? key}) : super(key: key);

  @override
  _ViewRegisterUserState createState() => _ViewRegisterUserState();
}

class _ViewRegisterUserState extends State<ViewRegisterUser> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _rowButton({required AuthenticationBloc authenticationBloc}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(child:
            ComponentElevatedButton(
              icon: Icons.save,
              title: 'Salvar',
              onPressed: () {

                if(_formKey.currentState!.validate()) {
                  User user = User(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text
                  );
                  log('User: $user');
                  authenticationBloc.add(SaveUserEvent(user: user));
                } else {
                  _rowMessage(message: 'Por favor, preencha todos os campos corretamente.', color: Colors.red);
                }
              }
            )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height / 11;
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: height),
                child: Image.asset(Constant.logo, height: 200),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('COVID-19', style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              ComponentTextFormField(controller: _nameController, icon: Icons.person, label: 'Nome'),
              ComponentTextFormField(controller: _emailController, icon: Icons.email, label: 'E-mail', isEmail: true),
              ComponentTextFormField(controller: _passwordController, icon: Icons.lock, label: 'Senha', isPassword: true, action: TextInputAction.done),
              _rowButton(authenticationBloc: authenticationBloc)
            ],
          ),
        ),
      ),
    );
  }

  _rowMessage({required String message, required Color color}) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: color,
          content: Text(message, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)
        )
    );
  }

}
