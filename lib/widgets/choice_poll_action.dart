import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';

class ChoicePollAction extends StatefulWidget {
  final ChoicePoll choicePoll;

  const ChoicePollAction({Key key, @required this.choicePoll})
      : super(key: key);

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

  int _votePercentage(int voteCount, int totalCount) =>
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
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: const [0.0, 1.0],
                    ),
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.choicePoll.options[i]),
                        Text(
                          '${_votePercentage(optionsVoteCount[i], totalCount)}'
                          '%',
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
                          '${_votePercentage(optionsVoteCount[i], totalCount)}'
                          '%',
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
