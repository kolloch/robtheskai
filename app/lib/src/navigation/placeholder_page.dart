import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final String text;

  const PlaceholderPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
