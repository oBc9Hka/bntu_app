import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.onChanged,
    this.validator,
    this.labelText,
    this.maxLines,
  }) : super(key: key);
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? labelText;
  final int? maxLines;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: widget.controller ?? TextEditingController(),
        onChanged: widget.onChanged,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.mainColor),
              borderRadius: BorderRadius.circular(8)),
        ),
        minLines: 1,
        maxLines: widget.maxLines ?? 4,
      ),
    );
  }
}
