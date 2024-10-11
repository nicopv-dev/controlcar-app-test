import 'dart:convert';
import 'dart:developer' as dev;

import 'package:controlcar_app_test/app/app_routes.dart';
import 'package:controlcar_app_test/models/pokemon.dart';
import 'package:controlcar_app_test/services/pokemon_service.dart';
import 'package:controlcar_app_test/utils/toast.dart';
import 'package:get/get.dart';

class PokemonController extends GetxController {
  var pokemons = List<Pokemon>.empty().obs;
  var isLoadingPokemons = true.obs;
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
    } finally {
      setIsLoadingPokemons(false);
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

  void setIsLoadingPokemons(bool value) {
    isLoadingPokemons.value = value;
  }

  Future<void> capturePokemon(String id) async {
    try {
      final response = await PokemonService.capturePokemon(id);
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        final index = pokemons.indexWhere((element) => element.id == id);
        pokemons[index].captured = true;
        Toast.show(
            message: '${pokemons[index].name.toUpperCase()} ha sido capturado');
        Get.toNamed(AppRoutes.captured);
      } else if (statusCode == 400) {
        Toast.show(message: 'El pokemon ya ha sido capturado');
      } else {
        Toast.show(message: 'No puedes capturar más de 6 pokemones');
      }
    } catch (e) {
      dev.log(e.toString());
      Toast.show(message: 'No puedes capturar más de 6 pokemones');
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
        Toast.show(
            message: '${pokemons[index].name.toUpperCase()} ha sido liberado');
        Get.toNamed(AppRoutes.captured);
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      pokemons.refresh();
    }
  }
}
