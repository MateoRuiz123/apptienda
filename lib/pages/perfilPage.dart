// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../main.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = UserData(); // Acceder a los datos del usuario

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nombre de usuario: ${userData.username ?? "Desconocido"}'),
            Text('Nivel: ${userData.nivel ?? "Desconocido"}'),
          ],
        ),
      ),
    );
  }
}
