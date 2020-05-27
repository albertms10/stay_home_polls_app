import 'package:flutter/material.dart';

class PollFormOptions extends StatefulWidget {
  final List<String> optionTitles;
  final Function(String, int) saveValue;
  final int initialOptionsCount;
  final List<String> initialOptions;

  PollFormOptions({
    Key key,
    @required this.optionTitles,
    this.saveValue,
    this.initialOptionsCount = 2,
    this.initialOptions,
  }) : super(key: key);

  @override
  _PollFormOptionsState createState() => _PollFormOptionsState();
}

class _PollFormOptionsState extends State<PollFormOptions> {
  List<TextEditingController> _controllers = [];

  bool get _canAddOptions => _controllers.length < widget.optionTitles.length;

  bool get _canRemoveOptions =>
      _controllers.length > widget.initialOptionsCount;

  void _addController([text = ""]) {
    if (_canAddOptions) _controllers.add(TextEditingController(text: text));
  }

  void _removeController(index) {
    if (_canRemoveOptions) _controllers.removeAt(index);
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialOptions != null)
      for (int i = 0; i < widget.initialOptions.length; i++)
        _addController(widget.initialOptions[i]);
    else
      for (int i = 0; i < widget.initialOptionsCount; i++) _addController();
  }

  void _initChecks() {
    if (widget.initialOptionsCount > widget.optionTitles.length)
      throw ('Failed assertion: initialOptionsCount <= optionTitle.length');

    if (widget.initialOptions != null &&
        widget.initialOptions.length < widget.initialOptionsCount)
      throw ('Failed assertion: initialOptions.length >= initialOptionsCount');
  }

  @override
  Widget build(BuildContext context) {
    _initChecks();

    return Column(
      children: <Widget>[
        for (int i = 0; i < _controllers.length; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _controllers[i],
                    validator: (option) {
                      if (option.isEmpty) return "Please, provide an option";
                      return null;
                    },
                    onSaved: (value) => widget.saveValue(value, i),
                    decoration: InputDecoration(
                      labelText: '${widget.optionTitles[i]} option',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                if (i >= widget.initialOptionsCount)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      tooltip: "Delete option",
                      color: Colors.grey[700],
                      onPressed: () => setState(() => _removeController(i)),
                    ),
                  ),
              ],
            ),
          ),
        if (_canAddOptions)
          OutlineButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add option'),
            onPressed: () => setState(_addController),
          ),
      ],
    );
  }
}
