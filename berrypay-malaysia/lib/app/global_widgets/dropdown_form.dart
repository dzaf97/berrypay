import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormDropdown extends StatefulWidget {
  FormDropdown({
    Key? key,
    required this.items,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final List<DropdownValue> items;
  Rx<DropdownValue> value;

  @override
  State<FormDropdown> createState() => _FormDropdownState();
}

class _FormDropdownState extends State<FormDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              widget.title,
              style: const TextStyle(color: Color(0xFF686777)),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE2E3E4)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<DropdownValue>(
              isExpanded: true,
              underline: Container(),
              value: widget.value.value,
              items: widget.items
                  .map((e) => DropdownMenuItem<DropdownValue>(
                        child: Text(e.name),
                        value: e,
                      ))
                  .toList(),
              onChanged: (_value) {
                widget.value.value = _value!;
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}

class DropdownValue {
  final String name;
  final int value;
  int? additionalValue;

  DropdownValue(
      {required this.name, required this.value, this.additionalValue});
}
