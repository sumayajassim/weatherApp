import 'package:flutter/material.dart';

const kTextFieldStyle = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
  hintText: 'Enter City name',
  hintStyle: TextStyle(color: Colors.grey),
  fillColor: Colors.white,
  filled: true,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
);
