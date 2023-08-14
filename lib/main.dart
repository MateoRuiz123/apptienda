import 'package:apptienda/pages/powerPage.dart';
import 'package:apptienda/pages/vendedoresPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

String username = '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const LoginPage(),
      routes: <String, WidgetBuilder>{
        '/powerPage': (BuildContext context) => const Power(),
        '/vendedoresPage': (BuildContext context) => const Vendedores(),
        '/loginPage': (BuildContext context) => const LoginPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controllerUser = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();

  String mensaje = '';

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://prueba-project.infinityfreeapp.com/login.php'),
      body: {
        'username': controllerUser.text,
        'password': controllerPass.text,
      },
    );

    print(response.body);

    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {
        mensaje = 'Login Fail';
      });
    } else {
      if (datauser[0]['nivel'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/powerPage');
      } else if (datauser[0]['nivel'] == 'ventas') {
        Navigator.pushReplacementNamed(context, '/vendedoresPage');
      }
      setState(() {
        username = datauser[0]['username'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
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
                        controller: controllerUser,
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
                        controller: controllerPass,
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
                        login();
                        Navigator.pop(context);
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
                      mensaje,
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
