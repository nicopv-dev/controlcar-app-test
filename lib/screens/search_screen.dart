import 'dart:convert';
import 'dart:developer' as dev;

import 'package:controlcar_app_test/models/category.dart';
import 'package:controlcar_app_test/models/pokemon.dart';
import 'package:controlcar_app_test/services/pokemon_service.dart';
import 'package:controlcar_app_test/widgets/pokemon_card.dart';
import 'package:controlcar_app_test/widgets/pokemon_skeleton.dart';
import 'package:controlcar_app_test/widgets/search/search_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:controlcar_app_test/utils/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  final fakeResultsCount = List.filled(
    10,
    Pokemon(
      id: '1',
      name: 'Bulbasaur',
      image:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
    ),
  );
  List<Category> filterTypes = [];
  String selectedFilter = 'Todos';
  List<Pokemon> results = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();

    getFilterTypes();
  }

  Future<void> getFilterTypes() async {
    try {
      final response = await PokemonService.getFilterTypes();
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = Category.fromJsonList(json);

        final all = Category(url: '', name: 'Todos');
        data.insert(0, all);
        setFilterTypes(data);
      }
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<void> search() async {
    try {
      setIsSearching(true);
      final response = await PokemonService.searchPokemon(
          searchController.text.trim(),
          selectedFilter == 'Todos' ? '' : selectedFilter);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = Pokemon.fromJsonList(json);

        setResults(data);
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setIsSearching(false);
    }
  }

  void setFilterTypes(List<Category> data) {
    setState(() {
      filterTypes = data;
    });
  }

  void setResults(List<Pokemon> data) {
    setState(() {
      results = data;
    });
  }

  void setIsSearching(bool value) {
    setState(() {
      isSearching = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Buscar pokemon'),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                )),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
            )),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Buscar patente",
                          // change background color of input
                          filled: true,
                          fillColor: Colors.grey[200],
                          // remove input border
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        controller: searchController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: search,
                      child: const Text(
                        "Buscar",
                        style: TextStyle(color: Constants.primaryColor),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                height: 40,
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterTypes.length,
                  itemBuilder: (context, index) {
                    final category = filterTypes[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SearchFilterButton(
                        label: category.name,
                        selected: category.name == selectedFilter,
                        onTap: () {
                          setState(() {
                            selectedFilter = category.name;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 6),
                child: Text(
                  'Resultados: ${results.length}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              isSearching
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Skeletonizer(
                        enabled: true,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: 10,
                          itemBuilder: (context, index) =>
                              const PokemonSkeleton(),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          if (isSearching) {
                            return const PokemonSkeleton();
                          } else {
                            final pokemon = results[index];
                            return PokemonCard(
                              id: pokemon.id,
                              name: pokemon.name,
                              image: pokemon.image,
                              captured: false,
                            );
                          }
                        },
                      ),
                    ),
            ],
          ),
        ));
  }
}
