import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: Colors.grey[700],
    ),
  );
}