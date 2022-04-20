import 'package:flutter/material.dart';

Widget loadingWidget(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(color: Colors.white),
    ),
  );
}
