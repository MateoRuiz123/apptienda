import 'package:apptienda/pages/editdata.dart';
import 'package:apptienda/pages/listarUsuarios.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({super.key, required this.index, required this.list});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    var url = Uri.parse("http://10.170.83.22/tienda/deletedata.php");
    http.post(
      url,
      body: {
        'id': widget.list[widget.index]['id'].toString(),
      },
    ).then((response) {
      print(response.body);
    }).catchError((error) {
      print("Error en la solicitud POST: $error");
    });
  }

  void Confimar() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Seguro desea eliminar '${widget.list[widget.index]['username']}'"),
      actions: [
        ElevatedButton(
          onPressed: () {
            deleteData();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => const ListarUser()),
            );
          },
          child: const Text("ok, eliminar"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancelar"),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['username']}"),
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                Text(
                  widget.list[widget.index]['username'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                const Divider(),
                Text(
                  "Nivel: ${widget.list[widget.index]['nivel']}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // boton editar con color blueAccent y redondeado a 30.0
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditData(
                            list: widget.list,
                            index: widget.index,
                          ),
                        ),
                      ),
                      child: const Text("Editar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const VerticalDivider(),
                    // boton eliminar con color redAccent y redondeado a 30.0
                    ElevatedButton(
                      onPressed: () => Confimar(),
                      child: const Text("Eliminar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
