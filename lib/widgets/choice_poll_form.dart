import 'package:flutter/material.dart';

class ChoicePollForm extends StatelessWidget {
  final TextEditingController firstController;
  final TextEditingController secondController;
  final TextEditingController thirdController;
  final TextEditingController fourthController;

  const ChoicePollForm({
    @required this.firstController,
    @required this.secondController,
    @required this.thirdController,
    @required this.fourthController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: firstController,
          decoration: InputDecoration(
            labelText: 'First option',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: secondController,
          decoration: InputDecoration(
            labelText: 'Second option',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        OutlineButton.icon(
          icon: Icon(Icons.add),
          label: Text('Add option'),
          onPressed: () {},
        ),
      ],
    );
  }
}
