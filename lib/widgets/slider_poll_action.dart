import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/slider_poll_thumb_circle.dart';
import 'package:stay_home_polls_app/widgets/slider_poll_track_shape.dart';

class SliderPollAction extends StatefulWidget {
  final SliderPoll sliderPoll;

  const SliderPollAction({@required this.sliderPoll});

  @override
  _SliderPollActionState createState() => _SliderPollActionState();
}

class _SliderPollActionState extends State<SliderPollAction> {
  double _voteValue;
  bool _voted;

  @override
  void initState() {
    super.initState();

    _voteValue = widget.sliderPoll.voteValue != null
        ? widget.sliderPoll.voteValue.toDouble()
        : 0.0;
    _voted = widget.sliderPoll.voteValue != null;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void Function(double) _getVoteFunction() =>
      _voted ? null : (value) => setState(() => _voteValue = value);

  void _finishedVoting(double newVote) {
    setState(() => _voted = true);

    Provider.of<User>(context, listen: false)
        .vote(widget.sliderPoll, _voteValue.floor());
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = SliderTheme.of(context).copyWith(
      trackHeight: 4.0,
      trackShape: SliderPollTrackShape(
        average: _voted ? widget.sliderPoll.voteAverage : null,
      ),
      thumbShape: SliderPollThumbCircle(
        thumbRadius: 40.0 * 0.4,
        min: 1,
        max: 100,
        voted: _voted,
      ),
    );

    SliderThemeData themeData;

    if (_voted) {
      themeData = baseTheme.copyWith(
        activeTrackColor: Colors.white.withOpacity(1.0),
        inactiveTrackColor: Colors.white.withOpacity(0.3),
        overlayColor: Colors.white.withOpacity(0.4),
        valueIndicatorColor: Colors.white,
        activeTickMarkColor: Colors.white,
        inactiveTickMarkColor: Colors.red.withOpacity(0.7),
        disabledActiveTrackColor: Colors.white.withOpacity(0.8),
        disabledInactiveTrackColor: Colors.white.withOpacity(0.3),
      );
    } else {
      themeData = baseTheme.copyWith(
        activeTrackColor: Colors.teal.withOpacity(1.0),
        inactiveTrackColor: Colors.teal.withOpacity(0.3),
        overlayColor: Colors.teal.withOpacity(0.4),
        valueIndicatorColor: Colors.teal,
        activeTickMarkColor: Colors.teal,
        inactiveTickMarkColor: Colors.red.withOpacity(0.7),
        disabledActiveTrackColor: Colors.teal.withOpacity(0.8),
        disabledInactiveTrackColor: Colors.teal.withOpacity(0.3),
      );
    }

    final slider = SliderTheme(
      data: themeData,
      child: Slider(
        value: _voteValue,
        onChanged: _getVoteFunction(),
        onChangeEnd: _finishedVoting,
        min: 0,
        max: 100,
        divisions: 100,
      ),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
          child: _voted
              ? Container(
                  width: double.infinity,
                  height: 41,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal[200],
                        Colors.teal[400],
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.00),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: slider,
                )
              : slider,
        ),
        if (_voted)
          Text(
            'Average: ${widget.sliderPoll.voteAverage.round()}',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.sliderPoll.options.first,
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              widget.sliderPoll.options.last,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        )
      ],
    );
  }
}
