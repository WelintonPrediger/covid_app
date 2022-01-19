import 'package:flutter/material.dart';

class ComponentElevatedButton extends StatefulWidget {

  final GestureTapCallback onPressed;
  final String title;
  final IconData icon;
  final double? radius;
  final double? padding;

  const ComponentElevatedButton({Key? key, required this.icon, required this.title, required this.onPressed, this.radius, this.padding}) : super(key: key);

  @override
  _ComponentElevatedButtonState createState() => _ComponentElevatedButtonState();
}

class _ComponentElevatedButtonState extends State<ComponentElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.radius ?? 16))),
        padding: MaterialStateProperty.all(EdgeInsets.all(widget.padding ?? 10))
      ),
      onPressed: widget.onPressed,
      icon: Icon(widget.icon, size: 30),
      label: Text(widget.title, style: const TextStyle(fontSize: 24))
    );
  }
}

