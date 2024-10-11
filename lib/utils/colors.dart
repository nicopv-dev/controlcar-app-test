import 'dart:math';

import 'package:flutter/material.dart';

class PokemonColor {
  final Color bg;
  final Color overlay;

  PokemonColor({required this.bg, required this.overlay});
}

PokemonColor getRandomColor() {
  final List<Color> bg = [
    Colors.red[300]!,
    Colors.greenAccent[400]!,
    Colors.cyan[300]!,
    Colors.blue[300]!,
    Colors.orange[300]!,
    Colors.pink[300]!,
    Colors.amber[300]!,
    Colors.yellow[700]!,
  ];

  final List<Color> overlay = [
    Colors.red[900]!,
    Colors.greenAccent[700]!,
    Colors.cyan[400]!,
    Colors.blue[400]!,
    Colors.orange[400]!,
    Colors.pink[400]!,
    Colors.amber[400]!,
    Colors.yellow[600]!,
  ];

  // Selecciona un color aleatorio de la lista
  final random = Random();

  final index = random.nextInt(bg.length);

  final color = PokemonColor(bg: bg[index], overlay: overlay[index]);
  return color;
}
