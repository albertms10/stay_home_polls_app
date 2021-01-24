import 'package:flutter/material.dart';

class PollFormOptions extends StatefulWidget {
  final List<String> optionTitles;
  final void Function(String, int) saveValue;
  final int initialOptionsCount;
  final List<String> initialOptions;

  const PollFormOptions({
    Key key,
    @required this.optionTitles,
    this.saveValue,
    this.initialOptionsCount = 2,
    this.initialOptions,
  })  : assert(
          initialOptionsCount <= optionTitles.length,
          initialOptions != null &&
              initialOptions.length >= initialOptionsCount,
        ),
        super(key: key);

  @override
  _PollFormOptionsState createState() => _PollFormOptionsState();
}

class _PollFormOptionsState extends State<PollFormOptions> {
  List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();

    _controllers = [];

    if (widget.initialOptions != null) {
      for (final initialOption in widget.initialOptions) {
        _addController(initialOption);
      }
    } else {
      for (var i = 0; i < widget.initialOptionsCount; i++) {
        _addController();
      }
    }
  }

  bool get _canAddOptions => _controllers.length < widget.optionTitles.length;

  bool get _canRemoveOptions =>
      _controllers.length > widget.initialOptionsCount;

  void _addController([text = '']) {
    if (_canAddOptions) _controllers.add(TextEditingController(text: text));
  }

  void _removeController(index) {
    if (_canRemoveOptions) _controllers.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < _controllers.length; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controllers[i],
                    validator: (option) {
                      if (option.isEmpty) return 'Please, provide an option';

                      return null;
                    },
                    onSaved: (value) => widget.saveValue(value, i),
                    decoration: InputDecoration(
                      labelText: '${widget.optionTitles[i]} option',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                if (i >= widget.initialOptionsCount)
                  Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: 'Delete option',
                      color: Colors.grey[700],
                      onPressed: () => setState(() => _removeController(i)),
                    ),
                  ),
              ],
            ),
          ),
        if (_canAddOptions)
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add option'),
            onPressed: () => setState(_addController),
          ),
      ],
    );
  }
}
