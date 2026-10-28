
import 'package:flutter/material.dart';

Widget meuBotao(String texto, Color cor, VoidCallback metodo) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
      onPressed: metodo,
      style: ElevatedButton.styleFrom(
        backgroundColor: cor,
        minimumSize: Size(double.infinity, 50),
        foregroundColor: Colors.white,
      ),
      child: Text(texto),
    ),
  );
}
