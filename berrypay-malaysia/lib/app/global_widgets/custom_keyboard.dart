import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom keyboard
class CustomKeyBoard extends StatefulWidget {
  /// Theme for the widget. Read more [PinTheme]
  // final PinTheme pinTheme;

  /// special key to be displayed on the widget. Default is '.'
  final Widget? specialKey;

  /// on pressed function to be called when the submit button is pressed.
  final Function? onbuttonClick;

  /// on changed function to be called when the amount is changed.
  final Function(String)? onChanged;

  /// function to be called when special keys are pressed.
  final Function()? specialKeyOnTap;

  /// submit button text.

  /// maximum length of the amount.
  final int? maxLength;

  TextEditingController? amount = TextEditingController();

  CustomKeyBoard({
    Key? key,
    required this.maxLength,
    this.amount,
    this.specialKey,
    this.onbuttonClick,
    this.onChanged,
    this.specialKeyOnTap,
  }) : super(key: key);
  @override
  _CustomKeyBoardState createState() => _CustomKeyBoardState();
}

class _CustomKeyBoardState extends State<CustomKeyBoard> {
  String value = "";
  Widget buildNumberButton({int? number, Widget? icon, Function()? onPressed}) {
    getChild() {
      if (icon != null) {
        return icon;
      } else {
        return Text(
          number?.toString() ?? "",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColor.black,
          ),
        );
      }
    }

    return Expanded(
        child: CupertinoButton(
            key: icon?.key ?? Key("btn$number"),
            onPressed: onPressed,
            child: getChild()));
  }

  Widget buildNumberRow(List<int> numbers) {
    List<Widget> buttonList = numbers
        .map((buttonNumber) => buildNumberButton(
              number: buttonNumber,
              onPressed: () {
                if (value.length < widget.maxLength!) {
                  setState(() {
                    value = value + buttonNumber.toString();
                  });
                  widget.onChanged!(value);
                }
              },
            ))
        .toList();
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: buttonList,
    ));
  }

  Widget buildSpecialRow() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildNumberButton(
              icon: widget.specialKey ??
                  const Icon(
                    Icons.circle,
                    key: Key('specialKey'),
                    color: Colors.white,
                    size: 7,
                  ),
              onPressed: null),
          buildNumberButton(
            number: 0,
            onPressed: () {
              if (value.length < widget.maxLength!) {
                setState(() {
                  value = value + 0.toString();
                });
                widget.onChanged!(value);
              }
            },
          ),
          buildNumberButton(
              icon: const Icon(
                Icons.backspace,
                key: Key('backspace'),
                color: Colors.red,
              ),
              onPressed: () {
                if (value.isNotEmpty) {
                  setState(() {
                    value = value.substring(0, value.length - 1);
                  });
                }
                widget.onChanged!(value);
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.maxLength == null || widget.maxLength! < 1) {
      throw AssertionError('maxLength must be greater than 0');
    }
    return Column(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Center(
          child: IntrinsicWidth(
            child: TextField(
              keyboardType: TextInputType.none,
              onChanged: (value) {
                // logger('value : $value');
                // String newValue = value.replaceAll(',', '').replaceAll('.', '');
                // if (value.isEmpty || newValue == '00') {
                //   widget.amount!.clear();
                //   return;
                // }
                // double value1 = double.parse(newValue);
                // value = NumberFormat.currency(customPattern: '######.##')
                //     .format(value1 / 100);
                // widget.amount!.value = TextEditingValue(
                //   text: value,
                //   selection: TextSelection.collapsed(offset: value.length),
                // );
                // logger('hello ${widget.amount}');
              },
              decoration: const InputDecoration(
                  border: InputBorder.none, prefix: Text('RM')),
              controller: widget.amount,
              key: const Key('amtKey'),
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w700,
                fontSize: 48,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                buildNumberRow([1, 2, 3]),
                buildNumberRow([4, 5, 6]),
                buildNumberRow([7, 8, 9]),
                buildSpecialRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
