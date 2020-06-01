import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
    _selectedValue = widget.choicePoll.voteValue != null
        ? widget.choicePoll.voteValue
        : null;
    voted = widget.choicePoll.voteValue != null ? true : false;
  }

  _vote() => voted
      ? null
      : (value) {
          setState(() {
            _selectedValue = value;
            voted = true;
          });
          final user = Provider.of<User>(context, listen: false);
          user.vote(widget.choicePoll, value);
        };

  @override
  Widget build(BuildContext context) {
    List<double> votes = new List(4);

    for (int i = 0; i < widget.choicePoll.optionsVoteCount.length; i++)
      votes[i] =
          widget.choicePoll.optionsVoteCount[i] / widget.choicePoll.totalCount;

    return Column(
      children: <Widget>[
        for (int i = 0; i < widget.choicePoll.optionsVoteCount.length; i++)
          voted
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 40.0,
                    animationDuration: 2000,
                    percent: votes[i],
                    backgroundColor: Colors.teal[50],
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.choicePoll.options[i],
                        ),
                        Text(
                          '${(widget.choicePoll.optionsVoteCount[i] / widget.choicePoll.totalCount * 100).round()}%',
                        ),
                      ],
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.teal[(votes[i] * 10).round() * 100],
                  ),
                )
              : RadioListTile<int>(
                  title: Text(widget.choicePoll.options[i]),
                  secondary: voted
                      ? Text(
                          '${(widget.choicePoll.optionsVoteCount[i] / widget.choicePoll.totalCount * 100).round()}%')
                      : null,
                  value: i,
                  groupValue: _selectedValue,
                  onChanged: _vote(),
                ),
      ],
    );
  }
}

/* new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2500,
                percent: 0.8,
                center: Text("80.0%"),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.green,
              ), */
