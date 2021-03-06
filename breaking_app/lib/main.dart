// @dart=2.9
import 'package:breaking_app/src/provider/frases_provider.dart';
import 'package:breaking_app/src/provider/muertos_provider.dart';
import 'package:breaking_app/src/provider/personaje_provider.dart';
import 'package:breaking_app/src/screens/home_scroll_page.dart';
import 'package:flutter/material.dart';

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
          '/': (BuildContext context) => ScrollDesign(),
          //si no instancioamos la ruta aqui
          //la clase de ruta no sirve nada y no reconoce la nueva pagina
          'personaje': (BuildContext context) => PersonajeProvider(),

          'frases': (BuildContext context) => FrasesProvider(),
          'asesinatos': (BuildContext context) => MuertosProvider()
        });
  }
}
