import 'dart:developer';

import 'package:covid19/bloc/bloc_export.dart';
import 'package:covid19/model/model_export.dart';
import 'package:covid19/service/service_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {

  final CovidService _covidService;

  CovidBloc(this._covidService) : super(CovidInitState()) {

    on<CovidInitEvent>((event, emit) => _fetchAllData(event, emit));
    on<CovidFilterEvent>((event, emit) => _covidFilter(event, emit));
    on<CovidDetailEvent>((event, emit) => emit(CovidDetailState(covid: event.covid)));

  }

  Future<void> _fetchAllData(CovidInitEvent event, Emitter<CovidState> emit) async {

    log('Fetch All Data');

    emit(CovidLoadingState());

    try {

      List<Covid>? listCovidData = await _covidService.fetchAllData();

      if(listCovidData != null) {
        emit(CovidAllDataState(listCovidData: listCovidData));
      } else {
        emit(CovidErrorState(message: 'Ops não foi possível buscar os dados do Covid-19.'));
      }

    } catch(error) {
      emit(CovidErrorState(message: 'Ops algum erro ocorreu. $error'));
    }

  }

  Future<void> _covidFilter(CovidFilterEvent event, Emitter<CovidState> emit) async {

    log('Covid Filter');

    emit(CovidLoadingState());

    try {

      List<Covid>? listFilter = await _covidService.filterCovid(listFilters: event.listFilters);

      if(listFilter != null) {
        emit(CovidFilterState(listFiltered: listFilter));
      } else {
        emit(CovidErrorState(message: 'Não há resultados para sua pesquisa'));
      }

    } catch(error) {
      emit(CovidErrorState(message: 'Ops algum erro ocorreu. $error'));
    }

  }

}