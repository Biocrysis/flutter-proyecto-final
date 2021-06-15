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
                            onTap: () {
                              print('ola');
                            },
                            subtitle: Card(
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

/*   Widget customListBuilder() {
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
                                print('${posts![index].birthday}');
                              },
                              title: Text(''),
                              subtitle: Card(
                                
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  margin: EdgeInsets.all(15),
                                  elevation: 10,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Column(
                                      children: <Widget>[
                                        FadeInImage(
                                          // En esta propiedad colocamos la imagen a descargar
                                          image: NetworkImage(
                                              '${posts![index].img}'),

                                          // En esta propiedad colocamos el gif o imagen de carga
                                          // debe estar almacenado localmente
                                          placeholder:
                                              AssetImage('assets/loadnier.gif'),

                                          // En esta propiedad colocamos mediante el objeto BoxFit
                                          // la forma de acoplar la imagen en su contenedor
                                          fit: BoxFit.cover,

                                          // En esta propiedad colocamos el alto de nuestra imagen
                                          height: 260,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('${posts![index].name}'),
                                        )
                                      ],
                                    ),
                                  )))
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
  } */

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
