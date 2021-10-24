/* import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputField extends StatelessWidget {

  final TextEditingController _myController = TextEditingController();

  final int minValue, maxValue;
  int value;

  NumberInputField({ 
    Key? key,
    this.minValue = 0,
    this.maxValue = 100,
    this.value = 0
  }) : super(key: key);

  bool _isValidValue(int n) {
    return (n >= minValue && n <= maxValue);
  }

  void _tfValueChanged(String newValue) {
    if (newValue.isEmpty) {
      return;
    }

    int newVal = int.parse(newValue);
    if (_isValidValue(newVal)) {
      value = newVal;
    }
  }

  void _setTextFieldValue() {
    _myController.text = "$value";
  }

  void _incValue() {
    if (_isValidValue(value + 1)) {
      value++;
    }

    _setTextFieldValue();
  }

  void _decValue() {
    if (_isValidValue(value - 1)) {
      value--;
    }

    _setTextFieldValue();
  }

  void _initValues() {
    _setTextFieldValue();
  }

  @override
  Widget build(BuildContext context) {
    _initValues();

    EdgeInsets horInset = EdgeInsets.symmetric(horizontal: 5, vertical: 0);

    /* Decoration d = BoxDecoration(
      border: Border.all(
        width: 1,
        style: BorderStyle.solid
      )
    ); */

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          
        )
      ),
      padding: horInset,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /* Container(
            padding: horInset,
            child: Center(
              child: Text(
                (_label != null) ? _label.toString() : "",
                textAlign: TextAlign.center,
              ),
            )
          ), */

          Expanded(
            // fit: FlexFit.tight,
            child: Container(
              padding: horInset,
              // child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                      )
                    )
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  // textAlign: TextAlign.start,
                  controller: _myController,
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
                    child: Icon(Icons.arrow_drop_up_sharp),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: this._decValue,
                    child: Icon(Icons.arrow_drop_down_sharp),
                  ),
                ),
              ],
            ),
          ),
          
        ],
      )
    );
  }
} */