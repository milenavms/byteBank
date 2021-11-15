import 'package:bytebank/screens/transferencias/lista.dart';
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
      theme: ThemeData(
        primaryColor: Colors.green[800],
        accentColor: Colors
            .green[300], //cor secundária https://material.io/resources/color/
        //button,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: TextButton.styleFrom(
          backgroundColor: Colors.green[300],
          primary: Colors.grey[800],
        )),
        //input
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          labelStyle: TextStyle(color: Colors.grey),
        ),

        //primarySwatch: Colors.green,
      ),
      home: ListaTransferencia(),
    );
  }
}
