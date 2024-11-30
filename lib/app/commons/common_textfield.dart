import 'package:flutter/material.dart';

class CommonSearchField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final double borderWidth;
  final ValueChanged<String>? onChanged;
  final BorderRadius borderRadius;
  final TextInputType keyboardType;
  final TextStyle? hintStyle;

  const CommonSearchField(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      this.borderWidth = 1.1,
      this.onChanged,
      this.borderRadius = const BorderRadius.all(Radius.circular(2)),
      this.keyboardType = TextInputType.text,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        prefixIcon: Icon(prefixIcon),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: borderWidth,
          ),
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: borderWidth,
          ),
          borderRadius: borderRadius,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: borderWidth,
          ),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
