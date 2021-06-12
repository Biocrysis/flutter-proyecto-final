import 'dart:async';
import 'dart:convert';
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
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
  /* Widget _crearLista() {
    return RefreshIndicator(
      onRefresh: obtenerPagina1,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _listNumero.length,
        itemBuilder: (BuildContext context, index) {
          final _imagen = _listNumero[index];
          return FadeInImage(
            placeholder: AssetImage(''),
            image:
                NetworkImage('https://picsum.photos/500/500/?images=$_imagen'),
          );
        },
      ),
    );
  } */

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
                            title: Text('${posts![index].name}'),
                            subtitle: FadeInImage(
                                placeholder: AssetImage("assets/loadnier.gif"),
                                image: NetworkImage('${posts![index].img}')),
                            onTap: () {
                              _showMyDialog(context);
                              ultimoItem = index;
                            },
                          )
                        ],
                      ),
                    ));

                    /* return ListTile(
                      title: Text('${posts![index].name}'),
                      subtitle: FadeInImage(
                        placeholder: AssetImage("assets/loadnier.gif"),
                        image: NetworkImage('${posts![index].img}'),
                      ),
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

//creamos la alerta
  Widget _alertDialog(context) {
    return AlertDialog(
      title: Text('Sobre Nombre'),
      content: Text("${posts![ultimoItem].nickname}"),
    );
  }

  //creamos la alerta
  Future _showMyDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) => _alertDialog(context),
    );
  }
}
