import 'dart:convert';

import 'package:controlcar_app_test/utils/constants.dart';
import 'package:http/http.dart' as http;

class PokemonService {
  static Future<http.Response> import() async =>
      await http.get(Uri.parse('${Constants.API_URL}/pokemon/import'));

  static Future<http.Response> getCapturedPokemons() async =>
      await http.get(Uri.parse('${Constants.API_URL}/pokemon/captured'));

  static Future<http.Response> capturePokemon(String id) async =>
      await http.post(Uri.parse('${Constants.API_URL}/pokemon/capture'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'id': id}));

  static Future<http.Response> searchPokemon(
          int page, String name, String? type) async =>
      await http.get(Uri.parse(
          '${Constants.API_URL}/pokemon/search?page=$page&q=$name&type=$type'));

  static Future<http.Response> getFilterTypes() async =>
      await http.get(Uri.parse('${Constants.API_URL}/pokemon/types'));

  static Future<http.Response> removeCapturePokemon(String id) async =>
      await http.delete(Uri.parse('${Constants.API_URL}/pokemon/capture/$id'));
}
