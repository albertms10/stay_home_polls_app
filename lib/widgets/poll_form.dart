import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/widgets/poll_form_options.dart';
import 'package:stay_home_polls_app/widgets/poll_type_toggle_buttons.dart';

class PollForm extends StatefulWidget {
  @override
  _PollFormState createState() => _PollFormState();
}

class _PollFormState extends State<PollForm> {
  var _isSelected = [true, false];
  var _poll = Poll();
  var _titleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _saveTitleValue(String title) => setState(() => _poll.title = title);

  void _saveOptionValue(String option, int index) => setState(() {
        if (_poll.options == null) _poll.options = [];
        if (index >= _poll.options.length)
          _poll.options.add(option);
        else
          _poll.options[index] = option;
      });

  @override
  Widget build(BuildContext context) {
    const _sliderPollOptions = ["Left", "Right"];
    const _choicePollOptions = ["First", "Second", "Extra", "Extra"];

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            PollTypeToggleButtons(
              onPressed: (int index) {
                setState(() => _formKey.currentState.save());
                setState(() {
                  if (!_isSelected[index])
                    _isSelected = _isSelected.map((value) => !value).toList();
                });
              },
              isSelected: _isSelected,
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Question title',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: _saveTitleValue,
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  if (_isSelected[0])
                    PollFormOptions(
                      key: Key("slider"),
                      optionTitles: _sliderPollOptions,
                      initialOptions: _poll.options,
                      saveValue: _saveOptionValue,
                    )
                  else
                    PollFormOptions(
                      key: Key("choice"),
                      optionTitles: _choicePollOptions,
                      initialOptions: _poll.options,
                      saveValue: _saveOptionValue,
                    ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: OutlineButton(
                      child: Text('Create poll'),
                      onPressed: () {
                        if (_formKey.currentState.validate())
                          Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Validated')),
                          );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
