import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/slider_custom.dart';

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
    return voted
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(
                      Radius.circular(25),
                    ),
                    gradient: new LinearGradient(
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
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white.withOpacity(1),
                      inactiveTrackColor: Colors.white.withOpacity(.3),
                      trackHeight: 4.0,
                      thumbShape: CustomSliderThumbCircle(
                        thumbRadius: 40 * .4,
                        min: 1,
                        max: 100,
                      ),
                      overlayColor: Colors.white.withOpacity(.4),
                      valueIndicatorColor: Colors.white,
                      activeTickMarkColor: Colors.white,
                      inactiveTickMarkColor: Colors.red.withOpacity(.7),
                      disabledActiveTrackColor: Colors.white.withOpacity(.8),
                      disabledInactiveTrackColor: Colors.white.withOpacity(.3),
                    ),
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
          )
        : Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.teal.withOpacity(1),
                      inactiveTrackColor: Colors.teal.withOpacity(.3),
                      trackHeight: 4.0,
                      thumbShape: CustomSliderThumbCircle(
                        thumbRadius: 40 * .4,
                        min: 1,
                        max: 100,
                      ),
                      overlayColor: Colors.teal.withOpacity(.4),
                      valueIndicatorColor: Colors.teal,
                      activeTickMarkColor: Colors.teal,
                      inactiveTickMarkColor: Colors.red.withOpacity(.7),
                      disabledActiveTrackColor: Colors.teal.withOpacity(.8),
                      disabledInactiveTrackColor: Colors.teal.withOpacity(.3),
                    ),
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
              ),
            ],
          );
  }
}
