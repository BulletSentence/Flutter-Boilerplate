import 'package:flutter/material.dart';
import 'package:projectb/configs/colors.dart';

InputDecoration formStyleFunction(String hint) {
  final InputDecoration formDecorationStyle = InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 16, color: Colors.white60),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.white,
        style: BorderStyle.solid,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.white,
        style: BorderStyle.solid,
      ),
    ),
    filled: true,
    contentPadding: const EdgeInsets.all(15),
    fillColor: Colors.white10,
  );
  return formDecorationStyle;
}

InputDecoration formPasswordStyleFunction(
    String hint, var passVisible, context, Function()? callback) {
  InputDecoration formDecorationStyle = InputDecoration(
    suffixIcon: IconButton(
      icon: Icon(
        passVisible ? Icons.visibility : Icons.visibility_off,
        color: whiteColor,
      ),
      onPressed: () {
        callback!();
      },
    ),
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 16, color: Colors.white60),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.white,
        style: BorderStyle.solid,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.white,
        style: BorderStyle.solid,
      ),
    ),
    filled: true,
    contentPadding: const EdgeInsets.all(15),
    fillColor: Colors.white10,
  );
  return formDecorationStyle;
}
