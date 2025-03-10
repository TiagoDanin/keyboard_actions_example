import 'package:flutter/material.dart';

/// Um exemplo de formulário sem o KeyboardController, mostrando o problema original.
///
/// Este exemplo demonstra a limitação do teclado numérico do iOS, onde não há
/// botões "Next" ou "Done" para facilitar a navegação entre campos.
class SimpleFormNoKeyboardController extends StatefulWidget {
  const SimpleFormNoKeyboardController({Key? key}) : super(key: key);

  @override
  _SimpleFormNoKeyboardControllerState createState() =>
      _SimpleFormNoKeyboardControllerState();
}

class _SimpleFormNoKeyboardControllerState
    extends State<SimpleFormNoKeyboardController> {
  // Controladores para os campos de texto
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _observacaoController = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
    super.dispose();
  }
}
