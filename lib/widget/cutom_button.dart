import 'package:flutter/material.dart';

class CutomButton extends StatelessWidget {
  final VoidCallback fungsi;
  final String text;
  final double horizontal;
  final double vertical;
  final Color color;
  const CutomButton({
    super.key,
    required this.fungsi,
    required this.text,
    required this.horizontal,
    required this.vertical, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: fungsi,
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
