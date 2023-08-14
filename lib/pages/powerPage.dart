// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Power extends StatelessWidget {
  const Power({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power'),
      ),
      body: Column(
        // Aquí eliminamos la palabra clave 'const'
        children: <Widget>[
          const Text('Estamos en power'),
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
