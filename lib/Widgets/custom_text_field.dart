import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String lable;
  final FocusNode? focusNode;
  final FocusNode? requestFocus;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.lable,
    this.focusNode,
    this.requestFocus,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Field Can't be empty";
              }
              return null;
            },
            focusNode: focusNode,
            controller: controller,
            decoration: InputDecoration(label: Text(lable), border: InputBorder.none),
            keyboardType: TextInputType.number,
            onFieldSubmitted: (value) {
              if (requestFocus != null) {
                requestFocus!.requestFocus();
              }
            },
          ),
        ),
        const SizedBox(height: 25)
      ],
    );
  }
}
