import 'dart:convert';
import 'dart:ui';

import 'package:breaking_app/src/models/muertos_model.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MuertosProvider extends StatefulWidget {
  MuertosProvider({Key? key}) : super(key: key);

  @override
  _MuertosProviderState createState() => _MuertosProviderState();
}

class _MuertosProviderState extends State<MuertosProvider> {
  http.Client? cliente;
  static const String URLAPI = 'https://www.breakingbadapi.com/api/deaths';

//clase post de referencia json model
  List<Muerto>? posts;
  bool loading = false;
  bool error = false;

//clase que inicial todas las variables
  @override
  void initState() {
    // ignore: deprecated_member_use
    posts = <Muerto>[];
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
          .map((dynamic json) => posts!.add(Muerto.fromJSON(json)))
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
        appBar: AppBar(
          title: Text('Muertes'),
          backgroundColor: Colors.green[900],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
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
                    )))));
  }

  Widget customLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget customListBuilder() {
    final textStyle = TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
    return SafeArea(
        child: Container(
      child: posts!.isEmpty
          ? deataEmpty()
          : ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (BuildContext context, int index) {
                return FlipCard(
                  front: Column(
                    children: [
                      Container(
                        child: Card(
                          color: Colors.green[900],
                          child: ListTile(
                            title: Text(
                              'Responsable: ${posts![index].responsible}',
                              style: textStyle,
                            ),
                            leading: Icon(Icons.dangerous_sharp),
                          ),
                        ),
                      ),
                      Image(image: AssetImage('assets/bdeat.jpg'))
                    ],
                  ),
                  back: Column(
                    children: [
                      Container(
                        child: Card(
                          child: ListTile(
                            subtitle: Text(' causa: ${posts![index].cause}. \n' +
                                ' muerto: ${posts![index].death} \n ' +
                                'Ultimas palabras:  ${posts![index].lastWords} \n' +
                                ' Temporada:  ${posts![index].season} \n' +
                                ' Episodio:  ${posts![index].episode} \n' +
                                ' Numero de muertos"  ${posts![index].numberOfDeaths}'),
                          ),
                        ),
                      )
                    ],
                  ),
                );
                /* ListTile(
                  title: Text('${posts![index].responsible}'),
                  subtitle: Text('causa: ${posts![index].cause}. ' +
                      'muerto: ${posts![index].death}'),
                ); */
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
