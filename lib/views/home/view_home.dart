import 'dart:developer';

import 'package:covid19/bloc/bloc_export.dart';
import 'package:covid19/components/components_export.dart';
import 'package:covid19/model/model_export.dart';
import 'package:covid19/views/views_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewHome extends StatefulWidget {
  const ViewHome({Key? key}) : super(key: key);

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {

  late List<Covid> listCovidData;
  int? page = 1;

  _screen({required CovidBloc covidBloc, required List<Covid> listCovidData}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 App'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Pesquisar',
            onPressed: () => _showDialog(covidBloc: covidBloc),
            icon: const Icon(Icons.search)
          )
        ],
      ),
      body: listCovidData.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Não há informações no momento')
          ],
        ),
      )
          : ListView.builder(
              itemCount: listCovidData.length,
              itemBuilder: (context, index) {
                return ComponentCard(covid: listCovidData[index], onTap: () => covidBloc.add(CovidDetailEvent(covid: listCovidData[index])));
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(visible: page! > 1, child: FloatingActionButton(onPressed: () => covidBloc.add(CovidPreviousDataEvent(page: page! - 1)), tooltip: 'Voltar', child: const Icon(Icons.arrow_back_ios),)),
            FloatingActionButton(onPressed: () => covidBloc.add(CovidNextDataEvent(page: page! + 1)), tooltip: 'Próxima', child: const Icon(Icons.arrow_forward_ios_rounded),),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final _covidBloc = BlocProvider.of<CovidBloc>(context);

    return WillPopScope(
        child: BlocBuilder(
          bloc: _covidBloc,
          builder: (context, state) {

            if(state is CovidInitState) {
              _covidBloc.add(CovidInitEvent(page: page));

            } else if(state is CovidAllDataState) {
              page = state.page;
              listCovidData = state.listCovidData;
              return _screen(covidBloc: _covidBloc, listCovidData: listCovidData);

            } else if(state is CovidFilterState) {
              listCovidData = state.listFiltered!;
              return _screen(covidBloc: _covidBloc, listCovidData: listCovidData);

            } else if(state is CovidDetailState) {
              return ViewDetailData(covid: state.covid);
            }
            return const ComponentLoadingIndicator();
          },
        ),
        onWillPop: () => _covidBloc.add(CovidInitEvent()) as Future<bool>
    );
  }

  _showDialog({required CovidBloc covidBloc}) {
    return showDialog(
      context: context,
      builder: (context) => const DialogHomeFilter()
    ).then((value) {
      if(value[0] != -1) {
        covidBloc.add(CovidFilterEvent(listFilters: value));
      } else {
        log('Value: $value');
      }
    });
  }

}
