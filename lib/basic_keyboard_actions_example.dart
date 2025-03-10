import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

/// Um exemplo de formulário que utiliza o pacote keyboard_actions diretamente,
/// sem encapsulamento, para mostrar como seria a implementação básica.
class BasicKeyboardActionsExample extends StatefulWidget {
  const BasicKeyboardActionsExample({Key? key}) : super(key: key);

  @override
  _BasicKeyboardActionsExampleState createState() =>
      _BasicKeyboardActionsExampleState();
}

class _BasicKeyboardActionsExampleState
    extends State<BasicKeyboardActionsExample> {
  // Controladores para os campos de texto
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _observacaoController = TextEditingController();

  // Focus nodes para cada campo
  final FocusNode _valorFocusNode = FocusNode();
  final FocusNode _quantidadeFocusNode = FocusNode();
  final FocusNode _observacaoFocusNode = FocusNode();

  // Resultado do formulário para exibição
  String _resultMessage = "";

  // Método chamado quando o formulário é enviado
  void _submitForm() {
    setState(() {
      _resultMessage = "Formulário enviado com sucesso!\n"
          "Valor: ${_valorController.text}\n"
          "Quantidade: ${_quantidadeController.text}\n"
          "Observação: ${_observacaoController.text}";
    });

    // Mostra uma mensagem
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Formulário enviado com sucesso!"),
        duration: Duration(seconds: 2),
      ),
    );

    // Fecha o teclado
    FocusScope.of(context).unfocus();
  }

  // Configuração do KeyboardActions
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _valorFocusNode,
          displayArrows: true,
          displayDoneButton: false,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => _quantidadeFocusNode.requestFocus(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              );
            },
          ],
        ),
        KeyboardActionsItem(
          focusNode: _quantidadeFocusNode,
          displayArrows: true,
          displayDoneButton: false,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => _observacaoFocusNode.requestFocus(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              );
            },
          ],
        ),
        KeyboardActionsItem(
          focusNode: _observacaoFocusNode,
          displayArrows: true,
          displayDoneButton: false,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => _submitForm(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "DONE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardActions(
        config: _buildConfig(context),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _buildValueField(),
              const SizedBox(height: 16),
              _buildQuantityField(),
              const SizedBox(height: 16),
              _buildNoteField(),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("ENVIAR FORMULÁRIO"),
                ),
              ),
              if (_resultMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _resultMessage,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Constrói o campo de valor
  Widget _buildValueField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Valor",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          focusNode: _valorFocusNode,
          controller: _valorController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Digite o valor",
            prefixIcon: Icon(Icons.attach_money),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  // Constrói o campo de quantidade
  Widget _buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quantidade",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          focusNode: _quantidadeFocusNode,
          controller: _quantidadeController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Digite a quantidade",
            prefixIcon: Icon(Icons.format_list_numbered),
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  // Constrói o campo de observação
  Widget _buildNoteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Observação",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          focusNode: _observacaoFocusNode,
          controller: _observacaoController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Digite uma observação",
            prefixIcon: Icon(Icons.note),
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          maxLines: 3,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _valorController.dispose();
    _quantidadeController.dispose();
    _observacaoController.dispose();
    _valorFocusNode.dispose();
    _quantidadeFocusNode.dispose();
    _observacaoFocusNode.dispose();
    super.dispose();
  }
}
