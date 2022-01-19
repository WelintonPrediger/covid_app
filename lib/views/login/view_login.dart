import 'dart:async';
import 'dart:developer';

import 'package:covid19/app_config/app_config_export.dart';
import 'package:covid19/bloc/bloc_export.dart';
import 'package:covid19/components/components_export.dart';
import 'package:covid19/model/model_export.dart';
import 'package:covid19/views/views_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewLogin extends StatefulWidget {
  const ViewLogin({Key? key}) : super(key: key);

  @override
  _ViewLoginState createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  double sizeHeight = 20.0;

  Widget _buttons({required AuthenticationBloc authenticationBloc}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ComponentElevatedButton(
                  title: 'Entrar',
                  icon: Icons.send_to_mobile,
                  onPressed: () {

                    if(_formKey.currentState!.validate()) {

                      User user = User(
                          email: _emailController.text,
                          password: _passwordController.text
                      );
                      log('User: $user');
                      authenticationBloc.add(LoginEvent(user: user));

                    } else {
                      _rowMessage(message: 'Por favor, preencha os campos corretamente', color: Colors.red);
                    }

                  },
                )
              ),
            ],
          ),
          SizedBox(height: sizeHeight),
          TextButton(
            onPressed: () {
              authenticationBloc.add(RegisterUserEvent());
            },
            child: const Text('Cadastre-se', style: TextStyle(fontSize: 20),)
          )
        ],
      ),
    );
  }

  Widget _screen({required double height, required AuthenticationBloc authenticationBloc}) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height),
                child: Image.asset(Constant.logo, height: 200),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('COVID-19', style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: height),
              ComponentTextFormField(controller: _emailController, icon: Icons.email, label: 'E-mail', isEmail: true, action: TextInputAction.next, keyboardType: TextInputType.emailAddress),
              ComponentTextFormField(controller: _passwordController, icon: Icons.lock, label: 'Senha', isPassword: true, action: TextInputAction.done),
              SizedBox(height: height),
              _buttons(authenticationBloc: authenticationBloc)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height / 11;
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return WillPopScope(
      child: BlocListener(
        bloc: _authenticationBloc,
        listener: (context, state) {
          if(state is SavedUserSuccess) {
            _rowMessage(message: state.message, color: Colors.green);

          } else if(state is InvalidLogin) {
            _rowMessage(message: state.message, color: Colors.red);
          }
        },
        child: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (context, state) {

            if(state is RegisterUserState) {
              return const ViewRegisterUser();

            } else if(state is AuthenticationLoadingState) {
              return const ComponentLoadingIndicator();

            } else if(state is AuthenticationErrorState) {
              return ComponentErrorMessage(message: state.message);

            } else if(state is AuthenticatedUser) {
              Timer(const Duration(milliseconds: 50), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ViewHome())));
            }

            return _screen(height: height, authenticationBloc: _authenticationBloc);

          },
        ),
      ),
      onWillPop: () => _authenticationBloc.add(AuthenticationInitEvent()) as Future<bool>
    );
  }

  _rowMessage({required String message, required Color color}) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: color,
            duration: const Duration(seconds: 3),
            padding: const EdgeInsets.all(10.0),
            content: Text(message, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)
        )
    );
  }

}
