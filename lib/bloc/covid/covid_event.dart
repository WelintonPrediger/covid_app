import 'package:covid19/model/model_export.dart';
import 'package:equatable/equatable.dart';

abstract class CovidEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CovidInitEvent extends CovidEvent {

  final int? page;

  CovidInitEvent({this.page});
}

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

class CovidNextDataEvent extends CovidEvent {

  final int page;

  CovidNextDataEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class CovidPreviousDataEvent extends CovidEvent {

  final int page;

  CovidPreviousDataEvent({required this.page});

  @override
  List<Object> get props => [page];
}