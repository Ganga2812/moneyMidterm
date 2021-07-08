import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFF2a9d8f),
    ),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFf4a261),
    ),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);
