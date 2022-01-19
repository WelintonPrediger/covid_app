import 'dart:developer';

import 'package:covid19/components/components_export.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class DialogHomeFilter extends StatefulWidget {
  const DialogHomeFilter({Key? key}) : super(key: key);

  @override
  _DialogHomeFilterState createState() => _DialogHomeFilterState();
}

class _DialogHomeFilterState extends State<DialogHomeFilter> {

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _ibgeCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Widget _buttons() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))
              ),
              onPressed: () {
                Navigator.of(context).pop([-1]);
              },
              icon: const Icon(Icons.arrow_back_ios),
              label: const Text('Voltar')
            ),
            const SizedBox(width: 20.0),
            ComponentElevatedButton(
              icon: Icons.search,
              title: 'Pesquisar',
              onPressed: () {
                Navigator.of(context).pop([
                  _dateController.text.isEmpty ? null : _dateController.text,
                  _stateController.text.isEmpty ? null : _stateController.text.toUpperCase(),
                  _ibgeCodeController.text.isEmpty ? null : _ibgeCodeController.text
                ]);
              }
            )
          ],
        ),
      );
    }

    Widget _datePicker() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: DateTimePicker(
          locale: const Locale('pt', 'BR'),
          dateMask: 'd MMM, yyyy',
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.date_range_rounded, color: Colors.blue),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              label: const Text('Data')
          ),
          initialValue: '',
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          dateLabelText: 'Date',
          onChanged: (val) {
            _dateController.text = val;
          },
          validator: (val) {
            log('$val');
            return null;
          },
          onSaved: (val) => log('$val'),
        ),
      );
    }

    return Dialog(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: const [
                Icon(Icons.search, size: 60),
                Text('Filtro de pesquisa')
              ],
            ),
            _datePicker(),
            ComponentTextFormField(controller: _stateController, icon: Icons.map_rounded, label: 'Estado'),
            ComponentTextFormField(controller: _ibgeCodeController, icon: Icons.code, label: 'Código IBGE', keyboardType: TextInputType.number, action: TextInputAction.done),
            _buttons()
          ],
        ),
      ),
    );
  }
}
