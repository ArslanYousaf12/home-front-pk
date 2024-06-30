import 'package:flutter/material.dart';

class LabelInputField extends StatelessWidget {
  LabelInputField({super.key, this.labelString, required this.child});
  final Widget child;
  String? labelString;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(19),
          ),
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}
