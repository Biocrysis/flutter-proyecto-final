import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersonajeDetalle extends StatefulWidget {
  PersonajeDetalle({Key? key}) : super(key: key);

  @override
  _PersonajeDetalleState createState() => _PersonajeDetalleState();
}

class _PersonajeDetalleState extends State<PersonajeDetalle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
