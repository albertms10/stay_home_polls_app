import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ChoicePollAction extends StatefulWidget {
  final ChoicePoll choicePoll;

  const ChoicePollAction({@required this.choicePoll});

  @override
  _ChoicePollActionState createState() => _ChoicePollActionState();
}

class _ChoicePollActionState extends State<ChoicePollAction> {
  int _selectedValue;
  bool _voted;

  @override
  void initState() {
    super.initState();

    _selectedValue = widget.choicePoll.voteValue;
    _voted = widget.choicePoll.voteValue != null;
  }

  void Function(int) _getVoteFunction() => _voted
      ? null
      : (value) {
          setState(() {
            _selectedValue = value;
            _voted = true;
          });

          Provider.of<User>(context, listen: false)
              .vote(widget.choicePoll, value);
        };

  int _votePercentage(voteCount, totalCount) =>
      ((voteCount / totalCount) * 100.0).round();

  @override
  Widget build(BuildContext context) {
    final optionsVoteCount = widget.choicePoll.optionsVoteCount;
    final totalCount = widget.choicePoll.totalCount;

    return Column(
      children: [
        for (var i = 0; i < optionsVoteCount.length; i++)
          _voted
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 40.0,
                    animationDuration: 500,
                    percent: optionsVoteCount[i] / totalCount,
                    backgroundColor: Colors.teal[50],
                    linearGradient: LinearGradient(
                      colors: [
                        Colors.teal[400],
                        Colors.teal[700],
                      ]
                          .map(
                            (color) => color
                                .withOpacity(optionsVoteCount[i] / totalCount),
                          )
                          .toList(),
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                  secondary: _voted
                      ? Text(
                          '${_votePercentage(optionsVoteCount[i], totalCount)}%',
                        )
                      : null,
                  value: i,
                  groupValue: _selectedValue,
                  onChanged: _getVoteFunction(),
                ),
      ],
    );
  }
}
