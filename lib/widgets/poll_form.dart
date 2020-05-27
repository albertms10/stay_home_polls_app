import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/widgets/choice_poll_form.dart';
import 'package:stay_home_polls_app/widgets/slider_poll_form.dart';

class PollForm extends StatefulWidget {
  @override
  _PollFormState createState() => _PollFormState();
}

class _PollFormState extends State<PollForm> {
  List<bool> _isSelected;
  TextEditingController _titleController;
  TextEditingController _firstController;
  TextEditingController _secondController;
  TextEditingController _thirdController;
  TextEditingController _fourthController;

  @override
  void initState() {
    super.initState();
    _isSelected = [true, false];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            PollTypeToggleButtons(
              onPressed: (int index) {
                setState(() {
                  if (!_isSelected[index])
                    _isSelected = _isSelected.map((value) => !value).toList();
                });
              },
              isSelected: _isSelected,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Question title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            if (_isSelected[0])
              SliderPollForm(
                firstController: _firstController,
                secondController: _secondController,
              )
            else
              ChoicePollForm(
                firstController: _firstController,
                secondController: _secondController,
                thirdController: _thirdController,
                fourthController: _fourthController,
              )
          ],
        ),
      ),
    );
  }
}
