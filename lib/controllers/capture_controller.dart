import 'dart:convert';
import 'dart:developer' as dev;

import 'package:controlcar_app_test/models/pokemon.dart';
import 'package:controlcar_app_test/services/pokemon_service.dart';
import 'package:get/get.dart';

class CaptureController extends GetxController {
  var capturedPokemons = List<Pokemon>.empty().obs;

  @override
  void onInit() {
    super.onInit();

    fetchCapturedPokemons();
  }

  Future<void> fetchCapturedPokemons() async {
    try {
      final response = await PokemonService.getCapturedPokemons();

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = Pokemon.fromJsonList(json);

        capturedPokemons.value = data;
      }
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
