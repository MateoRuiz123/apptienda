// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Vendedores extends StatelessWidget {
  const Vendedores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas'),
      ),
      body: Column(
        children: <Widget>[
          const Text('Estamos en ventas'),
          // boton para volver a login
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/loginPage');
            },
            child: const Text('Vendedores'),
          ),
        ],
      ),
    );
  }
}