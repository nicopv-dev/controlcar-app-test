import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonSkeleton extends StatelessWidget {
  const PokemonSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
      effect: ShimmerEffect(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        duration: const Duration(seconds: 1),
      ),
      child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Bone.square(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
