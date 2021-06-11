import 'dart:async';

import 'package:breaking_app/src/provider/personaje_provider.dart';
import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  ListaPage({Key? key}) : super(key: key);

  @override
  _ListaPageState createState() => _ListaPageState();
}

//
double posicionScroll = 0.0;

class _ListaPageState extends State<ListaPage> {
  List<int> _listaNumeros = [];
  int _ultimo_item = 0;

  //metodo para inicializar objetos variables etc
  bool _isLoading = false;

  //crear el scroll inifinito
  ScrollController _scrollController = new ScrollController(
      initialScrollOffset: posicionScroll, keepScrollOffset: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (posicionScroll == 0) {
      _agregar10();
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //_agregar10();
        //primero nos esperamos y coomo este metdo ya contiene el de agregar
        fetchData();
      }
    });
  }

//destruye la pagian cuando salimos y por ende el scroll controller
//para evitar problemas de memeoria
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('listas'),
        ),
        body: Stack(
          children: [_crearLista(), _crearLoading()],
        )
        //_crearLista(),
        );
  }

  PersonajeProvider pprovider = new PersonajeProvider();

  Widget _crearLista() {
    return RefreshIndicator(
      //obtenerPagina1() no se pone parentesis porque no estamos ejecutando el
      //metodo , estamos pasando la referencia solamente...
      onRefresh: obtenerPagina1,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _listaNumeros.length,
        itemBuilder: (BuildContext context, int index) {
          final _imagen = _listaNumeros[index];
          return FadeInImage(
              placeholder: AssetImage("assets/loadnier.gif"),
              image: NetworkImage(
                  'https://picsum.photos/500/500/?images=$_imagen'));
        },
      ),
    );
  }

  void _agregar10() {
    for (var i = 0; i < 10; i++) {
      _ultimo_item++;
      _listaNumeros.add(_ultimo_item);
    }
    setState(() {});
  }

  Future<Null> obtenerPagina1() async {
    final duration = new Duration(seconds: 2);
    new Timer(duration, () {
      _listaNumeros.clear();
      _ultimo_item++;
      _agregar10();
    });

    return Future.delayed(duration);
  }

  //los future nos ayuda para crear tiempos de espera
  Future<Null> fetchData() async {
    _isLoading = true;
    setState(() {});
    final duracion = new Duration(seconds: 2);
    new Timer(duracion, respuestaHTTP);
  }

  void respuestaHTTP() {
    _isLoading = false;
    //este efecto cuando carga una imagen se sube poquito para mostrar que se cargo
    _scrollController.animateTo(_scrollController.position.pixels + 100,
        curve: Curves.fastOutSlowIn, duration: Duration(microseconds: 300));
    _agregar10();
  }

  Widget _crearLoading() {
    if (_isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      );
    } else {
      return Container();
    }
  }
} //fin clase
