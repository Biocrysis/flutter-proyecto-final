import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:breaking_app/src/models/referencia_json_model.dart';
import 'package:http/http.dart' as http;
import 'package:breaking_app/src/models/personajes_models.dart';
import 'package:flutter/material.dart';

class PersonajeProvider extends StatefulWidget {
  PersonajeProvider({Key? key}) : super(key: key);

  @override
  _PersonajeProviderState createState() => _PersonajeProviderState();
}

class _PersonajeProviderState extends State<PersonajeProvider> {
  http.Client? cliente;
  static const String URLAPI = 'https://www.breakingbadapi.com/api/characters';

//clase post de referencia json model
  List<Personaje>? posts;
  bool loading = false;
  bool error = false;

//DISEÑO PARA LA LISTA DE IMAGENS DE LOS PERSONAJES
  List<int> _listNumero = [];
  int ultimoItem = 0;
//clase que inicial todas las variables
  @override
  void initState() {
    // ignore: deprecated_member_use
    posts = <Personaje>[];
    cliente = http.Client();
    obtenerDataFromJSON();

    super.initState();
  }

  Future<void> obtenerDataFromJSON() async {
    http.Response respuesta = await cliente!.get(Uri.parse(URLAPI));
    if (respuesta.statusCode == 200) {
      //creamos un mapa para decodificar el json
      List jsonData = jsonDecode(utf8.decode(respuesta.bodyBytes));
      jsonData
          .map((dynamic json) => posts!.add(Personaje.fromJSON(json)))
          .toList();
    } else {
      Exception('a fallado la conexion de la respuesta');
    }
    setState(() {
      loading = false;
      error = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        //loading? == SE ESTA CARGANDO EL CONTENIDO DE CUSTOMLOADING?
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/fon2.jpg'), fit: BoxFit.fill),
          ),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.01)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child:
                              loading ? customLoading() : customListBuilder())
                    ],
                  ))),
        ));

    //Container(child: loading ? customLoading() : customListBuilder()));
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
        top: true,
        child: Container(
          child: posts!.isEmpty
              ? deataEmpty()
              : ListView.builder(
                  itemCount: posts!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SafeArea(
                        child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            onTap: () {
                              _showMyDialog(context, index);
                            },
                            subtitle: Card(
                              color: Colors.green[400],
                              child: ExpansionTile(
                                title: Text(
                                  '${posts![index].name}',
                                ),
                                children: [
                                  FadeInImage(
                                      placeholder:
                                          AssetImage("assets/loadnier.gif"),
                                      image: NetworkImage(
                                        '${posts![index].img}',
                                      ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
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

//creamos la alerta
  Widget _alertDialog(context, index) {
    return AlertDialog(
      title: Text('Informacion del personaje'),
      content: Text(
          "Nombre: ${posts![index].name} \n Apodo: ${posts![index].nickname} \n  Cumpleaños: ${posts![index].birthday} \n Ocupacion: ${posts![index].occupation} \n estado: ${posts![index].status} \n Apariencias: ${posts![index].appearance} \n Actor: ${posts![index].portrayed} \n Serie(s): ${posts![index].category}"),
      actions: <Widget>[
        Row(
          children: [
            RaisedButton(
                color: Colors.green,
                child: Text(
                  "ok",
                  style: const TextStyle(color: Colors.white),
                ),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        )
      ],
      backgroundColor: Colors.green[800],
    );
  }

  Future _showMyDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (_) => _alertDialog(context, index),
    );
  }
}
