import 'package:flutter/material.dart';
import 'package:keyboard_actions_example/comparison_example.dart';

/// Aplicativo de exemplo para demonstrar o uso do KeyboardActionsController.
/// Este aplicativo mostra como resolver o problema da ausência de botões
/// de navegação no teclado numérico do iOS.
void main() {
  runApp(const KeyboardActionsExampleApp());
}

/// O widget principal do aplicativo de exemplo.
class KeyboardActionsExampleApp extends StatelessWidget {
  const KeyboardActionsExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard Actions Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ComparisonExample(),
    );
  }
}
