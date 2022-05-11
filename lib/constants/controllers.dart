import 'package:flutter/material.dart';

ScrollController listScrollController = ScrollController();

void navigateTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
