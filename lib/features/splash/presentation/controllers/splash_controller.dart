import 'package:flutter/material.dart';
import 'dart:async';

class SplashController {
  final AnimationController flipController;
  final AnimationController exitController;

  SplashController({required TickerProvider vsync})
    : flipController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 1000),
      ),
      exitController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 800),
      );

  Animation<double> get flip => CurvedAnimation(parent: flipController, curve: Curves.easeInOut);

  Animation<double> get scale => Tween(
    begin: 1.0,
    end: 5.5,
  ).animate(CurvedAnimation(parent: exitController, curve: Curves.easeIn));

  Animation<double> get opacity => Tween(begin: 1.0, end: 0.0).animate(exitController);

  Future<void> play({required VoidCallback onFinish}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    await flipController.forward();

    await Future.delayed(const Duration(milliseconds: 400));

    await exitController.forward();

    onFinish();
  }

  void dispose() {
    flipController.dispose();
    exitController.dispose();
  }
}
