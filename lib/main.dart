import 'dart:convert';
import 'dart:io';
import 'package:apptienda/pages/powerPage.dart';
import 'package:apptienda/pages/vendedoresPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

String username = '';
String msg = '';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/vendedores': (BuildContext context) => const Vendedores(),
        '/power': (BuildContext context) => const Power(),
        '/loginPage': (BuildContext context) => LoginPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('http://10.170.83.30/tienda/login.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': _usernameController.text,
          'password': _passwordController.text,
        },
      ),
    );

    print(response.body);

    var datauser = json.decode(response.body);
    print(datauser); // Verifica la respuesta del servidor en la consola

    if (datauser != null && datauser.containsKey('nivel')) {
      final role =
          datauser['nivel']; // Obtén el rol del usuario desde los datos
      if (role == 'admin') {
        Navigator.pushReplacementNamed(context, '/power');
      } else if (role == 'ventas') {
        Navigator.pushReplacementNamed(context, '/vendedores');
      } else {
        // Manejar otros roles o mostrar un mensaje de error
      }
      setState(() {
        username = datauser['username'];
      });
    } else {
      // Mostrar mensaje de error o manejar la respuesta incorrecta
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username')),
            TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}
