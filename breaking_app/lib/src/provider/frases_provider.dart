import 'dart:convert';
import 'dart:ui';

import 'package:breaking_app/src/models/frases_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FrasesProvider extends StatefulWidget {
  FrasesProvider({Key? key}) : super(key: key);

  @override
  _FrasesProviderState createState() => _FrasesProviderState();
}

class _FrasesProviderState extends State<FrasesProvider> {
  http.Client? cliente;
  static const String URLAPI = 'https://www.breakingbadapi.com/api/quotes';

//clase post de referencia json model
  List<Frase>? posts;
  bool loading = false;
  bool error = false;

//clase que inicial todas las variables
  @override
  void initState() {
    // ignore: deprecated_member_use
    posts = <Frase>[];
    cliente = http.Client();
    obtenerDataFromJSON();

    super.initState();
  }

  Future<void> obtenerDataFromJSON() async {
    http.Response respuesta = await cliente!.get(Uri.parse(URLAPI));
    if (respuesta.statusCode == 200) {
      //creamos un mapa para decodificar el json
      List jsonData = jsonDecode(utf8.decode(respuesta.bodyBytes));
      jsonData.map((dynamic json) => posts!.add(Frase.fromJSON(json))).toList();
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
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          }),
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
                    ]),
              ))),
    );
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
        child: Container(
      child: posts!.isEmpty
          ? deataEmpty()
          : ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${posts![index].getAuthor}: ' +
                      '${posts![index].getQuote}'),
                  //subtitle: Text('${posts![index].getBody}.'),
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
