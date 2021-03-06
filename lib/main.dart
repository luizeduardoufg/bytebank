import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
          TextEditingController(),
      _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando transferẽncia'),
      ),
      body: Column(
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
            onPressed: () => _criaTransferencia(),
          ),
        ],
      ),
    );
  }

  void _criaTransferencia() {
    final String _numeroConta = _controladorCampoNumeroConta.text;
    final double _valor = double.parse(_controladorCampoValor.text);

    if (_numeroConta != null && _valor != null) {
      final _transferencia = Transferencia(_valor, _numeroConta);
    }
  }
}

class CampoInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Icon icon;

  CampoInput({this.controller, this.labelText, this.hintText, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icon,
          labelText: labelText,
          hintText: hintText,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100.00, '1000')),
          ItemTransferencia(Transferencia(200.00, '1001')),
          ItemTransferencia(Transferencia(300.00, '1002')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(this._transferencia.valor.toString()),
        subtitle: Text(this._transferencia.numeroConta),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final String numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
