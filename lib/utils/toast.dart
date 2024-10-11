import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  static void show({required String message, int duration = 4}) =>
      toastification.showCustom(
          alignment: Alignment.bottomCenter,
          autoCloseDuration: Duration(seconds: duration),
          dismissDirection: DismissDirection.vertical,
          builder: (context, holder) {
            return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]),
              child: Row(
                children: [
                  Image.asset('assets/images/pokeball.png', width: 30),
                  const SizedBox(width: 4),
                  Text(message,
                      style: TextStyle(color: Colors.black.withOpacity(0.8))),
                ],
              ),
            );
          });
}
