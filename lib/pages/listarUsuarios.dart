// ignore_for_file: file_names

import 'package:apptienda/pages/detail.dart';
import 'package:apptienda/pages/powerPage.dart';
import 'package:apptienda/pages/registroUsuarios.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ListarUser extends StatefulWidget {
  const ListarUser({super.key});

  @override
  State<ListarUser> createState() => _ListarUserState();
}

class _ListarUserState extends State<ListarUser> {
  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://10.170.83.22/tienda/getdata.php"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de Usuarios"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // regresar a la pantalla anterior y refrescar
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const Power(),
            ));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const AddData(),
          ));
        },
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          // ignore: avoid_print
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data!,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // ignore: unnecessary_null_comparison
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        final nombre = list[i]['username'] ?? 'Nombre no disponible';
        final nivel = list[i]['nivel'] ?? 'Nivel no disponible';

        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => Detail(
                  list: list,
                  index: i,
                ),
              ),
            ),
            child: Card(
              child: ListTile(
                title: Text(
                  nombre,
                  style: const TextStyle(fontSize: 25.0, color: Colors.blue),
                ),
                leading: const Icon(
                  Icons.person_pin,
                  size: 77.0,
                  color: Colors.orangeAccent,
                ),
                subtitle: Text(
                  "Nivel: $nivel",
                  style: const TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
