import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'keyboard_controller.dart';

/// Um exemplo de formulário que utiliza o KeyboardActionsController para melhorar a navegação entre campos.
///
/// Este exemplo demonstra como criar um formulário com múltiplos campos de entrada
/// e usar o KeyboardActionsController para facilitar a navegação e a conclusão do formulário,
/// especialmente em dispositivos iOS onde o teclado numérico não possui botões de navegação nativos.
class CustomKeyboardActionsExample extends StatefulWidget {
  const CustomKeyboardActionsExample({Key? key}) : super(key: key);

  @override
  _CustomKeyboardActionsExampleState createState() =>
      _CustomKeyboardActionsExampleState();
}

class _CustomKeyboardActionsExampleState extends State<CustomKeyboardActionsExample> {
  // Controladores para os campos de texto
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _observacaoController = TextEditingController();

  // FocusNodes para cada campo de texto
  late List<FocusNode> _focusNodes;

  // Resultado do formulário para exibição
  String _resultMessage = "";

  @override
  void initState() {
    super.initState();

    // Inicializa a lista de FocusNodes
    _focusNodes = List.generate(3, (_) => FocusNode());
  }

  @override
  void dispose() {
    // Limpa os controladores e FocusNodes
    _valorController.dispose();
    _quantidadeController.dispose();
    _observacaoController.dispose();

    for (var node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardActions(
        // Usa o KeyboardActionsController para configurar a barra de ações do teclado
        config: KeyboardActionsController.buildConfigKeyboardActions(
          context: context,
          focusNodesSteps: _focusNodes,
          doneCallback: _submitForm,
        ),
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
          focusNode: _focusNodes[0],
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
          focusNode: _focusNodes[1],
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
          focusNode: _focusNodes[2],
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
}
