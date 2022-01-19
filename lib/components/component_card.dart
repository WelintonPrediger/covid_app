import 'package:covid19/model/model_export.dart';
import 'package:flutter/material.dart';

class ComponentCard extends StatelessWidget {

  final Covid covid;
  final GestureTapCallback onTap;

  const ComponentCard({Key? key, required this.covid, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height = 15.0;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                blurRadius: 3,
                spreadRadius: 2
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${covid.state!} ${covid.city == null || covid.city!.isEmpty ? '...' : covid.city}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: height),
              Text('Poulação Estimada: ${covid.estimatedPopulation!}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
              SizedBox(height: height / 2),
              Text('Código IBGE: ${covid.ibgeCityCode!}'),
              SizedBox(height: height / 2),
              Text('Total de Casos: ${covid.confirmed!}'),
              SizedBox(height: height / 2),
              Text('Óbitos: ${covid.deaths!}'),
              SizedBox(height: height / 2),
              Text('Indice de Óbitos: ${covid.deathRate!}%'),
              SizedBox(height: height / 2),
            ],
          ),
        ),
      ),
    );
  }
}
