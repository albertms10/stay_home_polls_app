import 'package:flutter/material.dart';

class SliderPollForm extends StatelessWidget {
  final TextEditingController firstController;
  final TextEditingController secondController;

  const SliderPollForm({
    @required this.firstController,
    @required this.secondController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: firstController,
          decoration: InputDecoration(
            labelText: 'Left option',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: secondController,
          decoration: InputDecoration(
            labelText: 'Right option',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
