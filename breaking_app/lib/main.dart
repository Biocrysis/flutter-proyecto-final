import 'package:breaking_app/src/pages/personaje_detalle.dart';
import 'package:flutter/material.dart';
import 'package:breaking_app/src/pages/home_page.dart';

//f2 para renombrar parametros owo
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
          //si no instancioamos la ruta aqui
          //la clase de ruta no sirve nada y no reconoce la nueva pagina
          'personaje': (BuildContext context) => PersonajeDetalle()
        });
  }
}