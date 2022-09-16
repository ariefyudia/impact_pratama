import 'package:flutter/material.dart';

class LabelFormWidget extends StatefulWidget {
  const LabelFormWidget({Key? key, required this.label}) : super(key: key);
  final String label;
  @override
  State<LabelFormWidget> createState() => _LabelFormWidgetState();
}

class _LabelFormWidgetState extends State<LabelFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
