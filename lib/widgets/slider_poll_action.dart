import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';

class SliderPollAction extends StatefulWidget {
  final SliderPoll sliderPoll;

  SliderPollAction({@required this.sliderPoll});

  @override
  _SliderPollActionState createState() => _SliderPollActionState();
}

class _SliderPollActionState extends State<SliderPollAction> {
  double voteValue;
  bool voted;

  @override
  void initState() {
    super.initState();
    voteValue = 0;
    voted = false;
  }

  _vote() => voted
      ? null
      : (newVote) {
          setState(() => voteValue = newVote);
        };

  _voted(newVote) => setState(() => voted = true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Slider(
          value: voteValue,
          onChanged: _vote(),
          onChangeEnd: _voted,
          min: 0,
          max: 100,
          divisions: 100,
          label: '${voteValue.floor()}',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.sliderPoll.options[0],
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Text(
              widget.sliderPoll.options[1],
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        )
      ],
    );
  }
}
