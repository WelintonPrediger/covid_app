import 'package:covid19/model/model_export.dart';
import 'package:equatable/equatable.dart';

abstract class CovidState extends Equatable {
  @override
  List<Object> get props => [];
}

class CovidInitState extends CovidState {}

class CovidLoadingState extends CovidState {}

class CovidAllDataState extends CovidState {

  final List<Covid> listCovidData;

  CovidAllDataState({required this.listCovidData});

}

class CovidFilterState extends CovidState {

  final List<Covid>? listFiltered;

  CovidFilterState({required this.listFiltered});
}

class CovidDetailState extends CovidState {

  final Covid covid;

  CovidDetailState({required this.covid});

  @override
  List<Object> get props => [covid];
}

class CovidErrorState extends CovidState {

  final String message;

  CovidErrorState({required this.message});

  @override
  List<Object> get props => [message];
}