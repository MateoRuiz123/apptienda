import 'package:flutter/material.dart';

class Vendedores extends StatelessWidget {
  const Vendedores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendedores'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navegar a la página de perfil y pasar los datos del usuario
              Navigator.pushNamed(
                context,
                '/perfil',
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              // Agregar aquí la lógica para cerrar sesión
              // Por ejemplo, eliminar las credenciales de inicio de sesión y navegar al login

              // Simulando un retraso para demostración
              await Future.delayed(Duration(seconds: 1));

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
      body: Center(
        child: Text('Vendedores'),
      ),
    );
  }
}
