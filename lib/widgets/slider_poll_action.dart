import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/slider_poll_thumb_circle.dart';
import 'package:stay_home_polls_app/widgets/slider_poll_track_shape.dart';

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
  void setState(cb) {
    if (this.mounted) super.setState(cb);
  }

  @override
  void initState() {
    super.initState();
    voteValue = widget.sliderPoll.voteValue != null
        ? widget.sliderPoll.voteValue.toDouble()
        : 0;
    voted = widget.sliderPoll.voteValue != null;
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
    SliderThemeData _baseTheme = SliderTheme.of(context).copyWith(
      trackHeight: 4.0,
      trackShape: SliderPollTrackShape(average: widget.sliderPoll.voteAverage),
      thumbShape: SliderPollThumbCircle(
        thumbRadius: 40 * .4,
        min: 1,
        max: 100,
        voted: voted,
      ),
    );

    SliderThemeData _data;
    if (voted)
      _data = _baseTheme.copyWith(
        activeTrackColor: Colors.white.withOpacity(1),
        inactiveTrackColor: Colors.white.withOpacity(.3),
        overlayColor: Colors.white.withOpacity(.4),
        valueIndicatorColor: Colors.white,
        activeTickMarkColor: Colors.white,
        inactiveTickMarkColor: Colors.red.withOpacity(.7),
        disabledActiveTrackColor: Colors.white.withOpacity(.8),
        disabledInactiveTrackColor: Colors.white.withOpacity(.3),
      );
    else
      _data = _baseTheme.copyWith(
        activeTrackColor: Colors.teal.withOpacity(1),
        inactiveTrackColor: Colors.teal.withOpacity(.3),
        overlayColor: Colors.teal.withOpacity(.4),
        valueIndicatorColor: Colors.teal,
        activeTickMarkColor: Colors.teal,
        inactiveTickMarkColor: Colors.red.withOpacity(.7),
        disabledActiveTrackColor: Colors.teal.withOpacity(.8),
        disabledInactiveTrackColor: Colors.teal.withOpacity(.3),
      );

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              gradient: LinearGradient(
                  colors: [
                    Colors.teal[200],
                    Colors.teal[400],
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.00),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: SliderTheme(
              data: _data,
              child: Slider(
                value: voteValue,
                onChanged: _vote(),
                onChangeEnd: _voted,
                min: 0,
                max: 100,
                divisions: 100,
              ),
            ),
          ),
        ),
        if (voted)
          Text(
            'Average: ${widget.sliderPoll.voteAverage.round()}',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.sliderPoll.options[0],
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              widget.sliderPoll.options[1],
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        )
      ],
    );
  }
}
