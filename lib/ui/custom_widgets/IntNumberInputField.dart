import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntNumberInputField extends StatefulWidget {
  int minValue, maxValue, value, step;
  double width;
  bool editEnabled;
  final ValueChanged<int>? onValueChanged;
  final _IntNumberInputFieldState _myState = _IntNumberInputFieldState();

  IntNumberInputField({
    Key? key,
    this.minValue = 0,
    this.maxValue = 100,
    this.value = 0,
    this.step = 1,
    this.onValueChanged,
    this.width = 150,
    this.editEnabled = true,
  }) : super(key: key);

  int getValue() {
    return this.value;
  }

  @override
  _IntNumberInputFieldState createState() => _myState;
}

class _IntNumberInputFieldState extends State<IntNumberInputField> {

  final TextEditingController _myController = TextEditingController();

  void setValue(int val) {
    if (_isValidValue(val)) {
      widget.value = val;
      _setTextFieldValue();
    }
  }

  @override
  void initState() {
    super.initState();

    _myController.text = widget.value.toString();
  }

  bool _isValidValue(int n) {
    return (n >= widget.minValue && n <= widget.maxValue);
  }

  void _setTextFieldValue() {
    widget.onValueChanged!(widget.value);
    _myController.text = widget.value.toString();
  }

  void _incValue() {
    if (_isValidValue(widget.value + widget.step)) {
      widget.value += widget.step;
      _setTextFieldValue();
    }
  }

  void _decValue() {
    if (_isValidValue(widget.value - widget.step)) {
      widget.value -= widget.step;
      _setTextFieldValue();
    }
  }

  void _tfValueChanged(String newValue) {
    if (newValue.isEmpty) {
      // return;
      newValue = "0";
    }

    int newVal = int.parse(newValue);
    if (!_isValidValue(newVal)) {
      newVal = 0;
    }
    widget.value = newVal;
    widget.onValueChanged!(widget.value);
  }



  @override
  Widget build(BuildContext context) {
    EdgeInsets horInset = EdgeInsets.symmetric(horizontal: 0, vertical: 0);

    return SizedBox(
      width: widget.width,
      height: 45,
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all()
          border: Border(
            bottom: BorderSide()
          )
        ),
        padding: horInset,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              // fit: FlexFit.tight,
              child: Container(
                padding: horInset,
                // child: Center(
                  child: TextField(
                    enabled: widget.editEnabled,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        )
                      )
                    ),
                    // textAlignVertical: TextAlignVertical.center,
                    // textAlign: TextAlign.start,
                    controller: _myController,
                    onChanged: _tfValueChanged,
                    onSubmitted: _tfValueChanged,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                // ) 
              ),
            ),

            Container(
              padding: horInset,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: this._incValue,
                      onLongPress: this._incValue,
                      child: Icon(Icons.arrow_drop_up_sharp),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: this._decValue,
                      onLongPress: this._decValue,
                      child: Icon(Icons.arrow_drop_down_sharp),
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        )
      )
    );
  }
}