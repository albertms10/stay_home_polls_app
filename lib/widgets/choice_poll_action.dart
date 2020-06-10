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
    voted = widget.choicePoll.voteValue != null;
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

  double _voteRatio(voteCount, totalCount) => voteCount / totalCount;

  int _votePercentage(voteCount, totalCount) =>
      (_voteRatio(voteCount, totalCount) * 100).round();

  @override
  Widget build(BuildContext context) {
    final List<int> optionsVoteCount = widget.choicePoll.optionsVoteCount;
    final int totalCount = widget.choicePoll.totalCount;

    return Column(
      children: <Widget>[
        for (int i = 0; i < optionsVoteCount.length; i++)
          voted
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 40.0,
                    animationDuration: 500,
                    percent: _voteRatio(optionsVoteCount[i], totalCount),
                    backgroundColor: Colors.teal[50],
                    linearGradient: LinearGradient(
                      colors: [
                        Colors.teal[400],
                        Colors.teal[700],
                      ]
                          .map(
                            (color) => color.withOpacity(
                              _voteRatio(optionsVoteCount[i], totalCount),
                            ),
                          )
                          .toList(),
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.choicePoll.options[i]),
                        Text(
                          '${_votePercentage(optionsVoteCount[i], totalCount)}%',
                        ),
                      ],
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                  ),
                )
              : RadioListTile<int>(
                  title: Text(widget.choicePoll.options[i]),
                  secondary: voted
                      ? Text(
                          '${_votePercentage(optionsVoteCount[i], totalCount)}%',
                        )
                      : null,
                  value: i,
                  groupValue: _selectedValue,
                  onChanged: _vote(),
                ),
      ],
    );
  }
}
