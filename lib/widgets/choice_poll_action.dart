import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';

class ChoicePollAction extends StatefulWidget {
  final ChoicePoll choicePoll;

  ChoicePollAction({@required this.choicePoll});

  @override
  _ChoicePollActionState createState() => _ChoicePollActionState();
}

class _ChoicePollActionState extends State<ChoicePollAction> {
  int _selectedValue;
  bool voted;

  @override
  void initState() {
    super.initState();
    voted = false;
  }

  _vote() => voted
      ? null
      : (value) {
          setState(() {
            _selectedValue = value;
            voted = true;
          });
          User.vote(widget.choicePoll, value);
        };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < widget.choicePoll.optionsVoteCount.length; i++)
          RadioListTile<int>(
            title: Text(widget.choicePoll.options[i]),
            secondary: voted
                ? Text(
                    '${(widget.choicePoll.optionsVoteCount[i] / widget.choicePoll.totalCount * 100).round()}%')
                : null,
            value: i,
            groupValue: _selectedValue,
            onChanged: _vote(),
          )
      ],
    );
  }
}
