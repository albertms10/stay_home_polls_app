import 'package:flutter/material.dart';

class PollTypeToggleButtons extends StatelessWidget {
  final Function(int) onPressed;
  final List<bool> isSelected;

  PollTypeToggleButtons({@required this.onPressed, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      selectedBorderColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(4),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          child: Column(
            children: <Widget>[
              Icon(Icons.tune),
              SizedBox(height: 4),
              Text('Slider'),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          child: Column(
            children: <Widget>[
              Icon(Icons.format_list_bulleted),
              SizedBox(height: 4),
              Text('Choice'),
            ],
          ),
        )
      ],
      onPressed: onPressed,
      isSelected: isSelected,
    );
  }
}
