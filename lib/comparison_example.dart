import 'package:flutter/material.dart';
import 'custom_keyboad_actions_example.dart';
import 'simple_form_no_keyboard_controller.dart';
import 'basic_keyboard_actions_example.dart';

/// Um exemplo que permite comparar as três implementações diferentes.
class ComparisonExample extends StatefulWidget {
  const ComparisonExample({Key? key}) : super(key: key);

  @override
  _ComparisonExampleState createState() => _ComparisonExampleState();
}

class _ComparisonExampleState extends State<ComparisonExample> {
  int _currentIndex = 0;

  final List<Widget> _examples = [
    const SimpleFormNoKeyboardController(),
    const BasicKeyboardActionsExample(),
    const CustomKeyboardActionsExample(),
  ];

  final List<String> _titles = [
    "Sem Keyboard Actions",
    "Com Keyboard Actions Básico",
    "Com Keyboard Actions Customizado"
  ];

  final List<String> _descriptions = [
    "Este exemplo mostra o problema original com o teclado numérico do iOS, que não possui botões 'Next' ou 'Done' para facilitar a navegação.",
    "Este exemplo mostra como implementar o keyboard_actions diretamente, sem encapsulamento. Note como o código se torna repetitivo e difícil de manter.",
    "Este exemplo mostra como implementar o keyboard_actions de forma customizada, com a barra de ações do teclado e mais fácil de manter."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comparação de Implementações"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _titles[_currentIndex],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _descriptions[_currentIndex],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Center(
                  child: SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(
                        value: 0,
                        label: Text("Problema"),
                        icon: Icon(Icons.error_outline),
                      ),
                      ButtonSegment(
                        value: 1,
                        label: Text("Básico"),
                        icon: Icon(Icons.code),
                      ),
                      ButtonSegment(
                        value: 2,
                        label: Text("Solução"),
                        icon: Icon(Icons.check_circle_outline),
                      ),
                    ],
                    selected: {_currentIndex},
                    onSelectionChanged: (Set<int> newSelection) {
                      setState(() {
                        _currentIndex = newSelection.first;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _examples,
            ),
          ),
        ],
      ),
    );
  }
}
