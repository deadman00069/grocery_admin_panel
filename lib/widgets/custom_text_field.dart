import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController? controller;
  final Function? validate;
  final Function? save;

  const CustomTextField({
    Key? key,
    required this.hint,
    required this.label,
    this.controller,
    this.validate,
    this.save,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate!.call(),
      onSaved: (v) => save!.call(),
      decoration: InputDecoration(
        hintText: hint,
        label: Text(label),
      ),
    );
  }
}
