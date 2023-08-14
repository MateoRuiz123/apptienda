import 'package:flutter/material.dart';
import '../main.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = UserData(); // Acceder a los datos del usuario

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
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