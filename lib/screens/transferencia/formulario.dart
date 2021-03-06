import 'package:bytebank/components/campo_input.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatefulWidget {
  @override
  _FormularioTransferenciaState createState() =>
      _FormularioTransferenciaState();
}

class _FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
          TextEditingController(),
      _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando transferẽncia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CampoInput(
              controller: _controladorCampoNumeroConta,
              labelText: 'Numero da conta',
              hintText: '0000',
            ),
            CampoInput(
              controller: _controladorCampoValor,
              labelText: 'Valor',
              hintText: '0.00',
              icon: Icon(Icons.monetization_on),
            ),
            ElevatedButton(
              child: Text('Transferir'),
              onPressed: () {
                final Transferencia transferencia = _criaTransferencia();
                Navigator.pop(context, transferencia);
              },
            ),
          ],
        ),
      ),
    );
  }

  Transferencia _criaTransferencia() {
    final String numeroConta = _controladorCampoNumeroConta.text;
    final double valor = double.parse(_controladorCampoValor.text);

    if (numeroConta != null && valor != null) {
      return Transferencia(valor, numeroConta);
    }

    return null;
  }
}
