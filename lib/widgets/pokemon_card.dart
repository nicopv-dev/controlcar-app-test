import 'dart:developer' as dev;

import 'package:controlcar_app_test/controllers/pokemon_controller.dart';
import 'package:controlcar_app_test/utils/colors.dart';
import 'package:controlcar_app_test/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PokemonCard extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final bool captured;
  final bool showCaptured;
  final int totalCaptured;

  const PokemonCard({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.captured,
    this.showCaptured = false,
    required this.totalCaptured,
  });

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  final pokemonController = Get.find<PokemonController>();
  late PokemonColor color;

  @override
  void initState() {
    super.initState();
    color = getRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            dev.log(pokemonController.capturedPokemons.length.toString());

            Toast.show(message: 'Capturando pokemon...', duration: 4);
            pokemonController.capturePokemon(widget.id);
            pokemonController.fetchPokemons();
          },
          onDoubleTap: () {
            dev.log('Double tap pokemon captured: ${widget.captured}');
            if (widget.captured) {
              pokemonController.removeCapturePokemon(widget.id);
              pokemonController.fetchCapturedPokemons();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: !widget.captured ? color.bg : Colors.grey[350],
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.name.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.captured
                            ? Colors.grey[200]
                            : color.overlay.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.network(widget.image, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        widget.showCaptured
            ? Positioned(
                bottom: 15,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: widget.captured ? Colors.grey[200] : color.overlay,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    widget.captured ? 'Capturado' : 'No capturado',
                    style: TextStyle(
                      color: widget.captured ? Colors.black : Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
