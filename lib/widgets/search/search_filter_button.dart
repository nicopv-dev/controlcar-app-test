import 'package:controlcar_app_test/utils/constants.dart';
import 'package:flutter/material.dart';

class SearchFilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final Function() onTap;

  const SearchFilterButton(
      {super.key,
      required this.label,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: selected
                ? Constants.primaryColor
                : Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ));
  }
}
