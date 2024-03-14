import 'package:flutter/material.dart';

class LabelInputField extends StatelessWidget {
  const LabelInputField(
      {super.key, required this.labelString, required this.child});
  final Widget child;
  final String labelString;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            labelString,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(202, 255, 255, 255),
            ),
          ),
        ),
        Card(
          // margin: EdgeInsets.all(10),
          color: Colors.amber.shade200,
          elevation: 1,
          shadowColor: Colors.amber.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: child,
          ),
        ),
      ],
    );
  }
}
