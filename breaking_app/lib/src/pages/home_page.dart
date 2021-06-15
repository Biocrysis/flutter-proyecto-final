import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:breaking_app/src/models/personajes_models.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    List<String> nav = ['personaje', 'episodios', 'frases', 'asesinatos'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Menu'),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: nav.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${nav[index]}'),
              //metodo que depende el index nos va ayudara a irnos a diferentes paginas
              onTap: () => Navigator.of(context).pushNamed(nav[index]),
            );
          },
        ),
      ),
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
                  children: [_swiperTarjeta()],
                ))),
      ),
    );
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

  Widget _swiperTarjeta() {
    final _screenZise = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.only(top: 25.0),
        height: _screenZise.height * 0.5,
        width: _screenZise.width,
        child: Swiper(
          //regresa el poster de todas las peliculas
          itemBuilder: (BuildContext context, int index) {
            Text('tthtthr');
            return ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: FadeInImage(
                image: NetworkImage('${posts?[index].img}', scale: 0.5),
                placeholder: AssetImage('assets/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            );
          },
          autoplay: true,
          itemCount: 5,
          //itemWidth: 300.0,
          itemWidth: _screenZise.width * 0.6,
          itemHeight: _screenZise.height * 0.9,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
          layout: SwiperLayout.STACK,
        ));
    /*  return new Swiper(
      itemBuilder: (BuildContext context, index) {
        return new Image.network(
          '${posts?[index].img}',
        );
      },
      itemCount: 3,
      itemHeight: 300,
      itemWidth: 400,
    );
  } */
  }
}

/* import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:breaking_app/src/models/personajes_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  final List<Personaje> personajesList = [];
  http.Client? cliente;
  static const String URLAPI = 'https://www.breakingbadapi.com/api/characters';
  List<Personaje>? posts;

  Widget build(BuildContext context) {
    List<String> nav = ['personaje', 'episodios', 'frases', 'asesinatos'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Menu'),
      ),
      drawer: Drawer(
        elevation: 0.1,
        child: ListView.builder(
          itemCount: nav.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${nav[index]}'),
              //metodo que depende el index nos va ayudara a irnos a diferentes paginas
              onTap: () => Navigator.of(context).pushNamed(nav[index]),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fondo.jpg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.01)),
            child: Column(
              children: [Flexible(child: _swiperTarjeta())],
            ),
          ),
        ),
      ),
    );
  }

  Widget _swiperTarjeta() {
    return new Swiper(
      itemBuilder: (BuildContext context, index) {
        return new Image.network(
          '${posts?[index].img}',
        );
      },
      itemCount: 3,
      itemHeight: 300,
      itemWidth: 400,
    );
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
  }
}
 */
