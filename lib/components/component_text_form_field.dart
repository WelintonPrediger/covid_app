import 'package:flutter/material.dart';

class ComponentTextFormField extends StatefulWidget {

  final TextEditingController controller;
  final IconData icon;
  final String label;
  final double? radius;
  final Color? iconColor;
  final bool isPassword;
  final bool isEmail;
  final TextInputAction action;
  final TextInputType keyboardType;

  const ComponentTextFormField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.label,
    this.radius,
    this.iconColor,
    this.isPassword = false,
    this.isEmail = false,
    this.action = TextInputAction.next,
    this.keyboardType = TextInputType.text
  }) : super(key: key);

  @override
  State<ComponentTextFormField> createState() => _ComponentTextFormFieldState();
}

class _ComponentTextFormFieldState extends State<ComponentTextFormField> {

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        textInputAction: widget.action,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.radius ?? 16)),
          prefixIcon: Icon(widget.icon, color: widget.iconColor ?? Colors.blue),
          label: Text(widget.label),
          suffixIcon: widget.isPassword
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: _obscureText ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)
                          )
                        : null
        ),
        validator: (value) {

          if(value == null || value.isEmpty) {
            return 'Preecha o campo ${widget.label} corretamente';
          }

          if(widget.isEmail) {
            if(!value.contains('@') && !value.contains('.com')) {
              return 'Preencha um e-mail válido';
            }
          }

          return null;
        },
      ),
    );
  }
}
