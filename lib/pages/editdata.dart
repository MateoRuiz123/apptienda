import 'package:apptienda/pages/listarUsuarios.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final List list;
  final int index;

  const EditData({super.key, required this.list, required this.index});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNivel = TextEditingController();

  Future<void> editData() async {
    var url = Uri.parse("http://10.170.83.22/tienda/editdata.php");
    await http.post(url, body: {
      "id": widget.list[widget.index]['id'].toString(),
      "username": controllerUsername.text,
      "password": controllerPassword.text,
      "nivel": controllerNivel.text,
    });
  }

  @override
  void initState() {
    controllerUsername =
        TextEditingController(text: widget.list[widget.index]['username']);
    controllerPassword =
        TextEditingController(text: widget.list[widget.index]['password']);
    controllerNivel =
        TextEditingController(text: widget.list[widget.index]['nivel']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllerUsername,
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty) return "Ingresa un usuario";
                    },
                    decoration: const InputDecoration(
                      hintText: "Usuario",
                      labelText: "Usuario",
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.black),
                  title: TextFormField(
                    controller: controllerPassword,
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty) return "Ingresa una contraseña";
                    },
                    decoration: const InputDecoration(
                      hintText: "Contraseña",
                      labelText: "Contraseña",
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.black),
                  title: TextFormField(
                    controller: controllerNivel,
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty) return "Ingresa un nivel";
                    },
                    decoration: const InputDecoration(
                      hintText: "Nivel",
                      labelText: "Nivel",
                    ),
                  ),
                ),
                const Divider(
                  height: 1.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                ElevatedButton(
                  child: const Text("Guardar"),
                  onPressed: () {
                    editData().then((_) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const ListarUser(),
                        ),
                      );
                    }).catchError((error) {
                      // ignore: avoid_print
                      print("Error en la solicitud HTTP: $error");
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
