import 'package:flutter/material.dart';

class DropdownTextForm extends StatelessWidget {
  const DropdownTextForm({
    super.key,
    required this.controller,
    required this.title,
    required this.widget,
    this.isRequired = true,
  });

  final dynamic controller;
  final String title;
  final Widget widget;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
      // margin: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, 5)),
          ],
          border: Border.all(color: Colors.grey.shade200.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 15),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                width: 5,
              ),
              isRequired == true
                  ? Text(
                      '*',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.red),
                      textAlign: TextAlign.start,
                    )
                  : const SizedBox()
            ],
          ),
          widget,
        ],
      ),
    );
  }
}
