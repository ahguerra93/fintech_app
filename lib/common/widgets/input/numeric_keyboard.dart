import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(int digit);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Icon? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Icon? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  const NumericKeyboard({
    super.key,
    required this.onKeyboardTap,
    this.textColor = Colors.black,
    this.rightButtonFn,
    this.rightIcon,
    this.leftButtonFn,
    this.leftIcon,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
  });

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: <Widget>[
          Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: <Widget>[_calcButton('1'), _calcButton('2'), _calcButton('3')],
          ),
          Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: <Widget>[_calcButton('4'), _calcButton('5'), _calcButton('6')],
          ),
          Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: <Widget>[_calcButton('7'), _calcButton('8'), _calcButton('9')],
          ),
          Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(45),
                onTap: widget.leftButtonFn,
                child: Container(alignment: Alignment.center, width: 50, height: 50, child: widget.leftIcon),
              ),
              _calcButton('0'),
              InkWell(
                borderRadius: BorderRadius.circular(45),
                onTap: widget.rightButtonFn,
                child: Container(alignment: Alignment.center, width: 50, height: 50, child: widget.rightIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          widget.onKeyboardTap(int.parse(value));
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
          width: 80,
          height: 50,
          child: Text(
            value,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: widget.textColor),
          ),
        ),
      ),
    );
  }
}
