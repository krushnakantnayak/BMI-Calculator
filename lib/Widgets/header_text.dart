import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String title;
  const HeaderText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            )),
      ),
    );
  }
}
