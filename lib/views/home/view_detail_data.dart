import 'package:covid19/model/model_export.dart';
import 'package:covid19/utilities/utilities_export.dart';
import 'package:flutter/material.dart';

class ViewDetailData extends StatelessWidget {

  final Covid covid;

  const ViewDetailData({Key? key, required this.covid}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height = 20.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${covid.state} ${covid.city}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: height),
              Text('População Estimada: ${covid.estimatedPopulation} habitantes', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: height / 2),
              Text('População em 2019: ${covid.estimatedPopulation2019} habitantes', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: height / 2),
              Text('Casos Confirmados: ${covid.confirmed} casos', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: height / 2),
              Text('Casos p/ 100Mil hab: ${covid.confirmedPer100kInhabitants} casos', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: height / 2),
              Text('Óbitos: ${covid.deaths}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: height / 2),
              Text('Indice de Mortalidade: ${covid.deathRate}%', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: height / 2),
              Text('Código IBGE: ${covid.ibgeCityCode}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: height / 2),
              Text('Data: ${Conversion.convertData(covid.date!)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: height / 2),
              Text('Pedidos para o local: ${covid.orderForPlace}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: height / 2),
            ],
          ),
        ),
      ),
    );
  }
}
