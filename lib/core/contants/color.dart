import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff90B2F9);
const Color secondaryColor = Color(0xff90B2F8);

//Create a shader linear gradient
final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
