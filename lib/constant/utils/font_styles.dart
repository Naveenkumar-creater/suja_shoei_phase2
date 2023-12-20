import 'package:flutter/material.dart';

class Headings extends StatelessWidget {
  final String? heading;
  final String? subHeading;
  final String? text;
  final String? subText;
  final String? dropText;

  const Headings(
      {super.key,
      this.heading,
      this.subHeading,
      this.text,
      this.subText,
      this.dropText});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.titleLarge!.color;

    return Column(
      children: [
        if (heading != null)
          Text(
            heading!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        if (subHeading != null)
          Text(
            subHeading!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        if (text != null)
          Text(
            text!,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        if (dropText != null)
          Text(
            dropText!,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        if (subText != null)
          Text(
            subText!,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
