import 'package:controlcar_app_test/app/app_routes.dart';
import 'package:controlcar_app_test/controllers/pokemon_controller.dart';
import 'package:controlcar_app_test/widgets/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
              floatingActionButton: FloatingActionButton(
                onPressed: () => Get.toNamed(AppRoutes.captured),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.list_alt,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/pokeball.png',
                                width: 30),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              "Pokedex",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () => Get.toNamed(AppRoutes.search),
                            icon: const Icon(Icons.search))
                      ],
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: controller.pokemons.length,
                      itemBuilder: (context, index) {
                        final pokemon = controller.pokemons[index];

                        return PokemonCard(
                          id: pokemon.id,
                          name: pokemon.name,
                          image: pokemon.image,
                          captured: pokemon.captured,
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
