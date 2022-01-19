import 'package:covid19/bloc/bloc_export.dart';
import 'package:covid19/service/service_export.dart';
import 'package:covid19/views/views_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(create: (context) => AuthenticationBloc(AuthenticationService())),
          BlocProvider<CovidBloc>(create: (context) => CovidBloc(CovidService()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DigiStarts Test',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('pt_BR'),
            Locale('en')
          ],
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.aBeeZeeTextTheme()
          ),
          home: const ViewLogin(),
        )
    );
  }
}
