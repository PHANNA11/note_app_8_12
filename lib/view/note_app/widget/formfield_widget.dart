import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// ignore: must_be_immutable
class FromFieldWidget extends StatelessWidget {
  FromFieldWidget(
      {super.key,
      this.controller,
      this.hinText,
      this.maxLines,
      this.obscureText,
      this.readOnly,
      this.label});
  TextEditingController? controller;
  String? hinText;
  bool? readOnly;
  bool? obscureText;
  int? maxLines;
  String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
        readOnly: readOnly ?? false,
        minLines: maxLines ?? 1,
        decoration: InputDecoration(
          label: Text(label!),
          hintText: hinText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
