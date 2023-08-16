// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';

class Power extends StatelessWidget {
  const Power({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navegar a la página de perfil y pasar los datos del usuario
              Navigator.pushNamed(
                context,
                '/perfil',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              // Agregar aquí la lógica para cerrar sesión
              // Por ejemplo, eliminar las credenciales de inicio de sesión y navegar al login

              // Simulando un retraso para demostración
              await Future.delayed(const Duration(seconds: 1));

              // Eliminar las credenciales de inicio de sesión
              // Por ejemplo, utilizando SharedPreferences o algún otro método
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.clear();

              // Navegar al login
              Navigator.pushReplacementNamed(context, '/loginPage');
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2.0),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, 'pages/listarUsuarios');
                  },
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: const Icon(
                    Icons.list,
                    color: Colors.blueAccent,
                    size: 73.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2.0),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, 'pages/registrarUsuarios');
                  },
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: const Icon(
                    Icons.add,
                    color: Colors.blueAccent,
                    size: 73.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
