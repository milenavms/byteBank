import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone; // usa-se o ? pois o campo não é obrigatório

  const Editor({
    required this.controlador,
    required this.rotulo,
    required this.dica,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 20.0),
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
