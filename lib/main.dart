import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

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

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  _ListaTransferenciasState createState() => _ListaTransferenciasState();
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, index) {
          final transferencia = widget._transferencias[index];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioTransferencia(),
            ),
          );
          future.then((transferencia) {
            if (transferencia != null)
              setState(() => widget._transferencias.add(transferencia));
          });
        },
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
  final double _valor;
  final String _numeroConta;

  Transferencia(this._valor, this._numeroConta);

  get valor => _valor;

  get numeroConta => _numeroConta;

  @override
  String toString() {
    return 'Transferencia{valor: $_valor, numeroConta: $_numeroConta}';
  }
}
