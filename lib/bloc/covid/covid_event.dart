import 'package:covid19/model/model_export.dart';
import 'package:equatable/equatable.dart';

abstract class CovidEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CovidInitEvent extends CovidEvent {}

class CovidFilterEvent extends CovidEvent {

  final List<dynamic> listFilters;

  CovidFilterEvent({required this.listFilters});

  @override
  List<Object> get props => [listFilters];
}

class CovidDetailEvent extends CovidEvent {

  final Covid covid;

  CovidDetailEvent({required this.covid});

  @override
  List<Object> get props => [covid];
}