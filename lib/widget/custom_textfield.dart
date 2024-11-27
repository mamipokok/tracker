import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final IconButton? iconButton;
  final String text;
  final bool hide;
  final TextInputType keyboard;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.icon,
    this.iconButton,
    required this.text,
    required this.hide, required this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.white,
      ),
      keyboardType: keyboard,
      obscureText: hide,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: iconButton,
        suffixIconColor: Colors.white,
        prefixIcon: icon,
        prefixIconColor: Colors.white,
        labelText: text,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        fillColor: const Color.fromARGB(121, 158, 158, 158),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
