import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:breaking_app/src/models/personajes_models.dart';

class PersonajeProvider extends StatefulWidget {
  PersonajeProvider({Key? key}) : super(key: key);

  @override
  _PersonajeProviderState createState() => _PersonajeProviderState();
}

class _PersonajeProviderState extends State<PersonajeProvider> {
  http.Client? cliente;
  static const String URLAPI = 'https://www.breakingbadapi.com/api/characters';

//clase post de referencia json model
  List<Personaje>? personajes;
  bool loading = false;
  bool error = false;

//clase que inicial todas las variables
  @override
  void initState() {
    // ignore: deprecated_member_use
    personajes = <Personaje>[];
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
      jsonData
          .map((dynamic json) => personajes!.add(Personaje.fromJsonMap(json)))
          .toList();
      //  print(jsonData);
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
      child: personajes!.isEmpty
          ? deataEmpty()
          : ListView.builder(
              itemCount: personajes!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${personajes![index].name}'),
                  // subtitle: Text('${posts![index].getBody}.'),
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