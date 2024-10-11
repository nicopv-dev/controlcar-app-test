import 'dart:convert';
import 'dart:developer' as dev;

import 'package:controlcar_app_test/models/pokemon.dart';
import 'package:controlcar_app_test/services/pokemon_service.dart';
import 'package:get/get.dart';

class PokemonController extends GetxController {
  var pokemons = List<Pokemon>.empty().obs;
  var capturedPokemons = List<Pokemon>.empty().obs;

  @override
  void onInit() {
    super.onInit();

    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    try {
      final response = await PokemonService.import();

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = Pokemon.fromJsonList(json);

        pokemons.value = data;
      }
    } catch (e) {
      dev.log(e.toString());
    }
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

  void setPokemons(List<Pokemon> data) {
    pokemons.value = data;
  }

  Future<void> capturePokemon(String id) async {
    try {
      final response = await PokemonService.capturePokemon(id);
      if (response.statusCode == 200) {
        final index = pokemons.indexWhere((element) => element.id == id);
        pokemons[index].captured = true;
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      pokemons.refresh();
    }
  }

  Future<void> removeCapturePokemon(String id) async {
    try {
      final response = await PokemonService.removeCapturePokemon(id);
      if (response.statusCode == 200) {
        final index = pokemons.indexWhere((element) => element.id == id);
        pokemons[index].captured = false;
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      pokemons.refresh();
    }
  }
}
