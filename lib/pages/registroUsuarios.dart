import 'package:apptienda/pages/listarUsuarios.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNivel = TextEditingController();

  var _formkey = GlobalKey<FormState>();

  void addData() {
    var url = Uri.parse("http://10.170.83.22/tienda/adddata.php");

    http.post(url, body: {
      "username": controllerUsername.text,
      "password": controllerPassword.text,
      "nivel": controllerNivel.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar datos"),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: TextFormField(
                  controller: controllerUsername,
                  validator: (value) {
                    if (value == "") return "Ingresa un usuario";
                  },
                  decoration: InputDecoration(
                      labelText: "Usuario", hintText: "Ingresa un usuario"),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                title: TextFormField(
                  controller: controllerPassword,
                  validator: (value) {
                    if (value == "") return "Ingresa una contraseña";
                  },
                  decoration: InputDecoration(
                      labelText: "Contraseña",
                      hintText: "Ingresa una contraseña"),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                title: TextFormField(
                  controller: controllerNivel,
                  validator: (value) {
                    if (value == "") return "Ingresa un nivel";
                  },
                  decoration: InputDecoration(
                      labelText: "Nivel", hintText: "Ingresa un nivel"),
                ),
              ),
              const Divider(
                height: 1.0,
              ),
              Padding(padding: const EdgeInsets.all(10.0)),
              ElevatedButton(
                child: const Text("Agregar datos"),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    addData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListarUser()),
                    );
                  }
                },
                // estilo de boton
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              // boton salir
              ElevatedButton(
                child: const Text("Salir"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/powerPage');
                },
                // estilo de boton
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
