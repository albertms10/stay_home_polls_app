import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/widgets/poll_form_options.dart';
import 'package:stay_home_polls_app/widgets/poll_type_toggle_buttons.dart';

class PollForm extends StatefulWidget {
  const PollForm({Key key}) : super(key: key);

  @override
  _PollFormState createState() => _PollFormState();
}

class _PollFormState extends State<PollForm> {
  GlobalKey<FormState> _formKey;

  TextEditingController _titleController;

  Poll _poll;
  List<bool> _isSelected;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    _titleController = TextEditingController();

    _poll = Poll();
    _isSelected = [true, false];
  }

  void _saveTitleValue(String title) {
    setState(() => _poll.title = title);
  }

  void _saveOptionValue(String option, int index) {
    setState(() {
      _poll.options ??= [];

      if (index >= _poll.options.length) {
        _poll.options.add(option);
      } else {
        _poll.options[index] = option;
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const sliderPollOptions = ['Left', 'Right'];
    const choicePollOptions = ['First', 'Second', 'Extra', 'Extra'];

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PollTypeToggleButtons(
              onPressed: (index) {
                setState(() {
                  _formKey.currentState.save();

                  if (!_isSelected[index]) {
                    _isSelected = _isSelected.map((value) => !value).toList();
                  }
                });
              },
              isSelected: _isSelected,
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _titleController,
                    validator: (title) {
                      if (title.isEmpty) return 'Please, provide a title';
                      return null;
                    },
                    onSaved: _saveTitleValue,
                    decoration: const InputDecoration(
                      labelText: 'Question title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(),
                  const SizedBox(height: 16.0),
                  if (_isSelected.first)
                    PollFormOptions(
                      key: const Key('slider'),
                      optionTitles: sliderPollOptions,
                      initialOptions: _poll.options,
                      saveValue: _saveOptionValue,
                    )
                  else
                    PollFormOptions(
                      key: const Key('choice'),
                      optionTitles: choicePollOptions,
                      initialOptions: _poll.options,
                      saveValue: _saveOptionValue,
                    ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        _poll.isAuth = true;

                        Navigator.of(context).pop(
                          _isSelected.first
                              ? SliderPoll.fromPoll(_poll)
                              : ChoicePoll.fromPoll(
                                  _poll,
                                  optionsVoteCount: List.filled(
                                    _poll.options.length,
                                    0,
                                    growable: false,
                                  ),
                                ),
                        );
                      }
                    },
                    child: const Text('Create poll'),
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
