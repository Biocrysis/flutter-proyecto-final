import 'dart:convert';

import 'package:breaking_app/src/models/referencia_json_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersonajeDetalle extends StatefulWidget {
  PersonajeDetalle({Key? key}) : super(key: key);

  @override
  _PersonajeDetalleState createState() => _PersonajeDetalleState();
}

class _PersonajeDetalleState extends State<PersonajeDetalle> {
  http.Client? cliente;
  static const String URLAPI = 'https://jsonplaceholder.typicode.com/posts';

//clase post de referencia json model
  List<Post>? posts;
  bool loading = false;
  bool error = false;

//clase que inicial todas las variables
  @override
  void initState() {
    // ignore: deprecated_member_use
    posts = <Post>[];
    cliente = http.Client();
    obtenerDataFromJSON();
    // TODO: implement initState
    super.initState();
  }

  Future<void> obtenerDataFromJSON() async {
    http.Response respuesta = await cliente!.get(Uri.parse(URLAPI));
    if (respuesta.statusCode == 200) {
      //creamos un mapa para decodificar el json
      List jsonData = jsonDecode(utf8.decode(respuesta.bodyBytes));
      print(jsonData);
    } else {
      Exception('a fallado la conexion de la respuesta');
    }
    setState(() {
      loading = false;
      error = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //loading? == SE ESTA CARGANDO EL CONTENIDO DE CUSTOMLOADING?
        body:
            Container(child: loading ? customLoading() : customListBuilder()));
  }

  Widget customLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget customListBuilder() {
    return SafeArea(
        child: Container(
      child: posts!.isEmpty
          ? deataEmpty()
          : ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${posts![index].getTitle}'),
                  subtitle: Text('${posts![index].getBody}.'),
                );
              },
            ),
    ));
  }

  Widget deataEmpty() {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Lista vacia'),
          )
        ],
      ),
    );
  }
}
