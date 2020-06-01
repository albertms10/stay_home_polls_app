import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';

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
    voteValue = widget.sliderPoll.voteValue != null
        ? widget.sliderPoll.voteValue.toDouble()
        : 0;
    voted = widget.sliderPoll.voteValue != null ? true : false;
  }

  Function _vote() =>
      voted ? null : (value) => setState(() => voteValue = value);

  void _voted(newVote) {
    setState(() => voted = true);
    final user = Provider.of<User>(context, listen: false);
    user.vote(widget.sliderPoll, voteValue.floor());
  }

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
