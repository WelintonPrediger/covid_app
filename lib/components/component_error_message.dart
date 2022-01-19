import 'package:flutter/material.dart';

class ComponentErrorMessage extends StatelessWidget {

  final String message;

  const ComponentErrorMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(message),
            )
          ],
        ),
      ),
    );
  }
}
