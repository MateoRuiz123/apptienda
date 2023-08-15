import 'dart:convert';
import 'dart:io';
import 'package:apptienda/pages/perfilPage.dart';
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
        '/loginPage': (BuildContext context) => const LoginPage(),
        '/perfil': (BuildContext context) => Perfil(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class UserData {
  static final UserData _instance = UserData._internal();

  factory UserData() => _instance;

  UserData._internal();

  String? username;
  String? nivel;
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('http://10.170.82.219/tienda/login.php'),
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

    // print(response.body);

    var datauser = json.decode(response.body);
    // print(datauser); // Verifica la respuesta del servidor en la consola

    if (datauser != null && datauser.containsKey('nivel')) {
      final role =
          datauser['nivel']; // Obtén el rol del usuario desde los datos
      if (role == 'admin') {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/power');
      } else if (role == 'ventas') {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/vendedores');
      } else {
        // Manejar otros roles o mostrar un mensaje de error
      }
      UserData().username = datauser['username'];
      UserData().nivel = datauser['nivel'];
      // setState(() {
      //   username = datauser['username'];
      // });
    } else {
      // Mostrar mensaje de error o manejar la respuesta incorrecta
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Login')),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         TextField(
    //             controller: _usernameController,
    //             decoration: const InputDecoration(labelText: 'Username')),
    //         TextField(
    //             controller: _passwordController,
    //             decoration: const InputDecoration(labelText: 'Password')),
    //         const SizedBox(height: 20),
    //         ElevatedButton(onPressed: _login, child: const Text('Login')),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/digital.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 77.0),
                // ignore: sort_child_properties_last
                child: const CircleAvatar(
                  backgroundColor: Color(0x0f81f7f3),
                  child: Image(
                    width: 135,
                    height: 135,
                    image: AssetImage('assets/images/avatar.png'),
                  ),
                ),
                width: 170.0,
                height: 170.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 93),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: const EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 2))
                        ],
                      ),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          hintText: 'Username',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      margin: const EdgeInsets.only(top: 32),
                      padding: const EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 2))
                        ],
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          hintText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 6,
                          right: 32,
                        ),
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        _login();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      msg,
                      style: const TextStyle(fontSize: 25, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
