import 'package:controlcar_app_test/controllers/pokemon_controller.dart';
import 'package:controlcar_app_test/widgets/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CapturedScreen extends StatefulWidget {
  const CapturedScreen({super.key});

  @override
  State<CapturedScreen> createState() => _CapturedScreenState();
}

class _CapturedScreenState extends State<CapturedScreen> {
  final pokemonController = Get.find<PokemonController>();

  @override
  void initState() {
    super.initState();

    pokemonController.fetchCapturedPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: GetX<PokemonController>(builder: (controller) {
          return RefreshIndicator(
            onRefresh: controller.fetchPokemons,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(Icons.chevron_left),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Capturados (${controller.capturedPokemons.length})",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    controller.capturedPokemons.isEmpty
                        ? Center(
                            child: Text(
                              "No hay pokemones capturados",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[400],
                              ),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: controller.capturedPokemons.length,
                            itemBuilder: (context, index) {
                              final pokemon =
                                  controller.capturedPokemons[index];

                              return PokemonCard(
                                id: pokemon.id,
                                name: pokemon.name,
                                image: pokemon.image,
                                captured: false,
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
