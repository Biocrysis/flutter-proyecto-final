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

  @override
  void initState() {
    cliente = http.Client();
    obtenerDataFromJSON();
    // TODO: implement initState
    super.initState();
  }

  Future<void> obtenerDataFromJSON() async {
    http.Response respuesta = await cliente!.get(Uri.parse(URLAPI));
    if (respuesta.statusCode == 200) {
      print(respuesta.body);
    } else {
      Exception('a fallado la conexion de la respuesta');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Text('trabajando con la api de internet'),
      ),
    );
  }
}
