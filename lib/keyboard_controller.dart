import "package:flutter/material.dart";
import "package:keyboard_actions/keyboard_actions.dart";

/// Controlador para gerenciar ações de teclado avançadas em aplicações Flutter.
///
/// Este controlador resolve o problema da ausência de botões "Next" e "Done" no teclado
/// numérico do iOS, criando uma barra de ferramentas personalizada que facilita a navegação
/// entre os campos de um formulário.
class KeyboardController {
  /// Constrói os itens individuais para cada FocusNode na barra de ações do teclado.
  ///
  /// @param context O BuildContext atual
  /// @param focusNodesSteps Lista de FocusNodes, um para cada campo do formulário
  /// @param doneCallback Callback opcional que será chamado quando o usuário pressionar "Done" no último campo
  static List<KeyboardActionsItem> _buildKeyboardItems(
    BuildContext context,
    List<FocusNode> focusNodesSteps,
    VoidCallback? doneCallback,
  ) {
    return List.generate(
      focusNodesSteps.length,
      (index) {
        void previousStep() {
          focusNodesSteps[index - 1].requestFocus();
        }

        void nextStep() {
          focusNodesSteps[index + 1].requestFocus();
        }

        void doneStep() {
          focusNodesSteps[index].unfocus();
          doneCallback?.call();
        }

        return KeyboardActionsItem(
          focusNode: focusNodesSteps[index],
          displayDoneButton: false,
          displayArrows: false,
          toolbarButtons: [
            (node) {
              return IconButton(
                icon: const Icon(Icons.close),
                tooltip: "Close",
                iconSize: IconTheme.of(context).size,
                color: IconTheme.of(context).color,
                onPressed: node.unfocus,
              );
            },
            (_) {
              return IconButton(
                icon: const Icon(Icons.keyboard_arrow_up),
                tooltip: "Previous",
                iconSize: IconTheme.of(context).size,
                color: IconTheme.of(context).color,
                disabledColor: Theme.of(context).disabledColor,
                onPressed: index > 0 ? previousStep : null,
              );
            },
            (_) {
              return IconButton(
                icon: const Icon(Icons.keyboard_arrow_down),
                tooltip: "Next",
                iconSize: IconTheme.of(context).size,
                color: IconTheme.of(context).color,
                disabledColor: Theme.of(context).disabledColor,
                onPressed: index < focusNodesSteps.length - 1 ? nextStep : null,
              );
            },
            (_) => const Spacer(),
            (node) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextButton(
                  onPressed:
                      index < focusNodesSteps.length - 1 ? nextStep : doneStep,
                  child: Text(
                    index < focusNodesSteps.length - 1 ? "NEXT" : "DONE",
                    style: TextStyle(
                      color: IconTheme.of(context).color,
                    ),
                  ),
                ),
              );
            },
          ],
        );
      },
    );
  }

  /// Constrói a configuração completa para o widget KeyboardActions.
  ///
  /// @param context O BuildContext atual
  /// @param focusNodesSteps Lista de FocusNodes, um para cada campo do formulário
  /// @param doneCallback Callback opcional que será chamado quando o usuário pressionar "Done" no último campo
  /// @return Uma configuração KeyboardActionsConfig pronta para uso
  static KeyboardActionsConfig buildConfigKeyboardActions({
    required BuildContext context,
    required List<FocusNode> focusNodesSteps,
    VoidCallback? doneCallback,
  }) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: _buildKeyboardItems(context, focusNodesSteps, doneCallback),
    );
  }
}
