import 'dart:convert';
import 'dart:developer' as dev;

import 'package:controlcar_app_test/app/app_routes.dart';
import 'package:controlcar_app_test/models/category.dart';
import 'package:controlcar_app_test/models/pokemon.dart';
import 'package:controlcar_app_test/services/pokemon_service.dart';
import 'package:controlcar_app_test/widgets/pokemon_card.dart';
import 'package:controlcar_app_test/widgets/pokemon_skeleton.dart';
import 'package:controlcar_app_test/widgets/search/search_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:controlcar_app_test/utils/constants.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController =
      TextEditingController(text: '');

  List<Category> filterTypes = [];
  String selectedFilter = 'Todos';
  List<Pokemon> results = [];
  bool isSearching = false;
  int totalPages = 0;
  int totalResults = 0;
  int page = 1;

  @override
  void initState() {
    super.initState();

    getFilterTypes();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
          page,
          searchController.text.trim(),
          selectedFilter == 'Todos' ? '' : selectedFilter);
      dev.log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final tPages = json['totalPages'] as int;
        setTotalPages(tPages);
        final tResults = json['total'] as int;
        setTotalResults(tResults);

        final data = Pokemon.fromJsonList(json['results']);

        setResults(data);
      } else {
        setResults([]);
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

  void setPage(int value) {
    setState(() {
      page = value;
    });
  }

  void setTotalPages(int value) {
    setState(() {
      totalPages = value;
    });
  }

  void setTotalResults(int value) {
    setState(() {
      totalResults = value;
    });
  }

  void nextPage() {
    if (page < totalPages) {
      setPage(page + 1);
      search();
    }
  }

  void previousPage() {
    if (page > 1) {
      setPage(page - 1);
      search();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset('assets/images/pokeball.png', width: 30),
              const SizedBox(
                width: 4,
              ),
              const Text(
                "Controldex",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Constants.primaryColor,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
          ),
          surfaceTintColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(AppRoutes.captured),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.list_alt,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Buscar Pokemon",
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
                          if (category.name != selectedFilter) {
                            setPage(1);
                          }
                          setState(() {
                            selectedFilter = category.name;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              results.isNotEmpty
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                color: Colors.grey,
                                icon: const Icon(Icons.chevron_left),
                                onPressed: previousPage,
                              ),
                              Text(
                                '$page/$totalPages',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                              IconButton(
                                color: Colors.grey,
                                icon: const Icon(Icons.chevron_right),
                                onPressed: nextPage,
                              ),
                            ],
                          ),
                          Text(
                            'Pokemones encontrados: $totalResults',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  : const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'No se encontraron resultados',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ],
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
                              showCaptured: true,
                              captured: pokemon.captured,
                              totalCaptured: 0,
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
