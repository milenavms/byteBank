import 'package:flutter/material.dart';

void main() {
  runApp(
    ByteBanckApp(),
  );
}

//App
class ByteBanckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

/*
 * TELA CRIA TRANSFERENCIAS 
 */

//Tela de Formulário de transferencia
class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

//Tela de Formulário de transferencia - State
class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      new TextEditingController();
  final TextEditingController _controladorCampoValor =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferencias'),
      ),
      body: SingleChildScrollView(
        //Lista com scroll
        child: Column(
          children: [
            Editor(
                controlador: _controladorCampoNumeroConta,
                rotulo: 'Número Conta',
                dica: '000'),
            Editor(
                controlador: _controladorCampoValor,
                rotulo: 'Valor',
                dica: '000',
                icone: Icons.monetization_on),
            ElevatedButton(
              onPressed: () => _criaTransferencia(
                  context), //button de confirmar a criação da transferencia
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('Criando transferência');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context,
          transferenciaCriada); //pop - Após Criar uma Transferencia, volta para a tela de Tranferencias.
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone; // usa-se o ? pois o campo não é obrigatório

  const Editor(
      {required this.controlador,
      required this.rotulo,
      required this.dica,
      this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 20.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null, //icone //Operador Ternário
          labelText: rotulo, //rotulo
          hintText: dica, //dica
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

/*
 *TELA LISTA TRANSFERENCIAS 
 */

//Tela Principal de Lista de Tranferencia (Dinâmica).
class ListaTransferencia extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];

          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //buton de criar uma nova transferenia
        onPressed: () {
          final Future<Transferencia?>
              future = //Tem acesso a uma possível resposta/retorno
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            //rota/navegação
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            //recebendo o valor
            debugPrint('chegou no then do future');
            debugPrint('$transferenciaRecebida');
            _atualiza(transferenciaRecebida!);
          });
        },
      ),
    );
  }

  void _atualiza(Transferencia transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia(valor:$valor, numeroConta: $numeroConta)'; //retornando os valores, int e double como uma string.
  }
}
