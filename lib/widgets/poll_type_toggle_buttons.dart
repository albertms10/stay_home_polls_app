import 'package:flutter/material.dart';

class PollTypeToggleButtons extends StatelessWidget {
  final void Function(int) onPressed;
  final List<bool> isSelected;

  const PollTypeToggleButtons({@required this.onPressed, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      selectedBorderColor: Theme.of(context).primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      children: const [
        PollTypeToggleButton(
          icon: Icon(Icons.tune),
          title: Text('Slider'),
        ),
        PollTypeToggleButton(
          icon: Icon(Icons.format_list_bulleted),
          title: Text('Choice'),
        ),
      ],
      onPressed: onPressed,
      isSelected: isSelected,
    );
  }
}

class PollTypeToggleButton extends StatelessWidget {
  final Text title;
  final Icon icon;

  const PollTypeToggleButton({@required this.title, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 16.0,
      ),
      child: Column(
        children: [
          icon,
          const SizedBox(height: 4.0),
          title,
        ],
      ),
    );
  }
}
